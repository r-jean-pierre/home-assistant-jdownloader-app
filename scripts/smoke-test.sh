#!/usr/bin/env bash

set -euo pipefail

image=$1
check_apparmor=${2:-false}
scratch=$(mktemp -d)
container=

cleanup() {
    local status=$?
    if [[ -n "$container" ]]; then
        if (( status != 0 )); then
            docker logs --tail 100 "$container" >&2 || true
            docker exec "$container" tail -n 80 /config/logs/output.log >&2 || true
        fi
        docker rm --force --volumes "$container" > /dev/null || true
    fi
    sudo rm -rf -- "$scratch"
}
trap cleanup EXIT

mkdir "$scratch/data" "$scratch/share"
yq -r '.environment | to_entries | .[] | .key + "=" + .value' jdownloader/config.yaml > "$scratch/env"

security_options=()
if [[ "$check_apparmor" == true ]]; then
    if ! command -v apparmor_parser > /dev/null; then
        sudo apt-get update -q
        sudo apt-get install --no-install-recommends -y apparmor
    fi
    sudo apparmor_parser --replace --skip-cache jdownloader/apparmor.txt
    security_options=(--security-opt apparmor=jdownloader)
    for folder in other jdownload jdownloader-backup; do
        mkdir "$scratch/share/$folder"
        touch "$scratch/share/$folder/fixture"
    done
fi

start_app() {
    container=$(docker run --detach --env-file "$scratch/env" \
        --mount "type=bind,source=$scratch/data,target=/data,readonly" \
        --mount "type=bind,source=$scratch/share,target=/output" \
        "${security_options[@]}" "$image")
}

wait_for_health() {
    local state
    for _ in {1..90}; do
        state=$(docker inspect --format '{{.State.Status}} {{.State.Health.Status}}' "$container")
        case "$state" in
            'running healthy') return 0 ;;
            'running starting') sleep 2 ;;
            *) break ;;
        esac
    done
    printf 'The container did not become healthy (last state: %s).\n' "$state" >&2
    return 1
}

printf '%s\n' '{"require_network_mount":false}' > "$scratch/data/options.json"
start_app
wait_for_health
docker exec "$container" /opt/base/sbin/nginx -t -c /opt/base/etc/nginx/nginx.conf
status=$(docker exec "$container" curl -sS --max-time 5 -o /dev/null \
    -w '%{http_code}' http://127.0.0.1:5800/)
if [[ "$status" != 403 ]]; then
    printf 'Expected HTTP 403 on a direct request, received HTTP %s.\n' "$status" >&2
    exit 1
fi

if [[ "$check_apparmor" == true ]]; then
    docker exec --user 0 "$container" sh -eu -c '
        touch /output/jdownloader/.smoke-test
        cat /output/jdownloader/.smoke-test
        rm /output/jdownloader/.smoke-test
        for folder in other jdownload jdownloader-backup; do
            if cat "/output/$folder/fixture" > /dev/null 2>&1 ||
               touch "/output/$folder/new-file" 2> /dev/null; then
                printf "AppArmor allowed access to /output/%s.\n" "$folder" >&2
                exit 1
            fi
        done
    '
fi

docker stop --time 60 "$container" > /dev/null
docker rm --volumes "$container" > /dev/null
container=

printf '%s\n' '{"require_network_mount":true}' > "$scratch/data/options.json"
start_app
timeout 90 docker wait "$container" > /dev/null
logs=$(docker logs "$container" 2>&1)
if [[ "$logs" != *'ERROR: SMB/NFS storage is required at /output/jdownloader.'* ]]; then
    printf 'The App did not report the expected missing network storage error.\n' >&2
    exit 1
fi

#!/bin/sh

set -eu

download_dir=/output/jdownloader
require_network_mount=false
if [ -f /data/options.json ]; then
    require_network_mount="$(jq -r '.require_network_mount == true' /data/options.json)"
fi

if [ "$require_network_mount" = false ]; then
    mkdir -p "$download_dir"
fi

# statfs activates a Home Assistant automount and probes the filesystem.
if ! fs_type="$(stat -f -c '%t' "$download_dir")"; then
    printf 'ERROR: Cannot access %s. Check network storage in Home Assistant.\n' "$download_dir" >&2
    exit 1
fi

# Linux filesystem magic values for SMB, CIFS, SMB2 and NFS.
case "$fs_type" in
    517b|ff534d42|fe534d42|6969)
        printf 'SMB/NFS storage detected at %s.\n' "$download_dir"
        ;;
    187)
        printf 'ERROR: Automount at %s did not resolve. Check network storage in Home Assistant.\n' "$download_dir" >&2
        exit 1
        ;;
    *)
        if [ "$require_network_mount" = true ]; then
            printf 'ERROR: SMB/NFS storage is required at %s. Check network storage in Home Assistant.\n' "$download_dir" >&2
            exit 1
        fi
        printf 'SMB/NFS storage was not detected at %s. Using the available filesystem.\n' "$download_dir"
        ;;
esac

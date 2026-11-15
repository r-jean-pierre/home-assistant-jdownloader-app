#!/bin/sh

set -u

APP_VERSION="$(cat /ha-app-version 2>/dev/null || printf 'unknown')"
UPSTREAM_IMAGE="$(cat /ha-upstream-image 2>/dev/null || printf 'unknown')"

if STARTED_AT="$(date -Iseconds 2>/dev/null)"; then
    :
else
    STARTED_AT="$(date)"
fi

echo ""
echo "============================================================"
echo " JDownloader 2 Home Assistant App"
echo " App version     : ${APP_VERSION}"
echo " Upstream image  : ${UPSTREAM_IMAGE}"
echo " Platform        : ${DOCKER_IMAGE_PLATFORM:-unknown}"
echo " App UID/GID     : ${USER_ID:-unset}/${GROUP_ID:-unset}"
echo " Ingress port    : ${WEB_LISTENING_PORT:-5800}"
echo " Config path     : /config (app-specific configuration)"
echo " Download path   : /output/jdownloader"
echo " HA share path   : /share/jdownloader"
echo " VNC TCP         : disabled"
echo " Started at      : ${STARTED_AT}"
echo "============================================================"

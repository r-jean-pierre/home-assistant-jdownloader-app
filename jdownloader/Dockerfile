FROM ghcr.io/jlesage/jdownloader-2:v26.09.1@sha256:bd6cd2fdc72818f30207e677b33cd7f1b425048c4e7132624e541e99f992be4c

ARG BUILD_ARCH=unknown
ARG BUILD_VERSION=dev
ARG UPSTREAM_IMAGE=ghcr.io/jlesage/jdownloader-2:v26.09.1
ARG UPSTREAM_DIGEST=sha256:bd6cd2fdc72818f30207e677b33cd7f1b425048c4e7132624e541e99f992be4c

COPY rootfs/ /

# Older local archives may have been extracted over the source directory.
RUN set -eux; \
    rm -f /etc/cont-init.d/11-ha-ingress.sh /etc/cont-init.d/56-ha-output-diagnostics.sh; \
    chmod 0755 \
        /etc/cont-init.d/07-ha-banner.sh \
        /etc/cont-init.d/54-ha-output.sh; \
    printf '%s\n' "${BUILD_VERSION}" > /ha-app-version; \
    printf '%s\n' "${UPSTREAM_IMAGE}" > /ha-upstream-image; \
    for cfg in \
        /defaults/cfg/org.jdownloader.settings.GeneralSettings.json \
        /defaults/cfg/org.jdownloader.gui.views.linkgrabber.addlinksdialog.LinkgrabberSettings.json \
        /defaults/cfg/org.jdownloader.gui.views.linkgrabber.addlinksdialog.LinkgrabberSettings.downloaddestinationhistory.json; \
    do \
        grep -Fq '"/output"' "${cfg}"; \
        sed -i 's#"/output"#"/output/jdownloader"#g' "${cfg}"; \
        jq -e . "${cfg}" > /dev/null; \
    done; \
    test -f /etc/cont-init.d/55-jdownloader2.sh; \
    sed -i \
        's#take-ownership --not-recursive --skip-if-writable /output$#take-ownership --not-recursive --skip-if-writable /output/jdownloader#' \
        /etc/cont-init.d/55-jdownloader2.sh; \
    grep -q \
        'take-ownership --not-recursive --skip-if-writable /output/jdownloader' \
        /etc/cont-init.d/55-jdownloader2.sh; \
    site=/opt/base/etc/nginx/default_site.conf; \
    test "$(grep -c '^server {$' "$site")" -eq 1; \
    sed -i '/^server {$/a\    include /opt/base/etc/nginx/include/ha-ingress.conf;' "$site"; \
    grep -Fq 'include /opt/base/etc/nginx/include/ha-ingress.conf;' "$site"

LABEL \
    io.hass.name="JDownloader 2" \
    io.hass.description="JDownloader 2 for Home Assistant with Ingress" \
    io.hass.type="app" \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.arch="${BUILD_ARCH}" \
    org.opencontainers.image.source="https://github.com/r-jean-pierre/home-assistant-jdownloader-app" \
    org.opencontainers.image.base.name="${UPSTREAM_IMAGE}" \
    org.opencontainers.image.base.digest="${UPSTREAM_DIGEST}"

HEALTHCHECK --interval=30s --timeout=10s --start-period=90s --retries=3 \
    CMD ["/bin/sh", "-c", "test -S /tmp/vnc.sock && nc -z -w5 127.0.0.1 \"${WEB_LISTENING_PORT:-5800}\""]

# Do not override CMD/ENTRYPOINT.
# The upstream jlesage /init remains PID 1 and keeps its native shutdown logic.

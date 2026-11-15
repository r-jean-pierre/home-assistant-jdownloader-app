# Changelog

## 0.1.7

- Remove the Experimental label from the Home Assistant App.

## 0.1.6

- Restrict the browser GUI to the Home Assistant Supervisor Ingress gateway.
- Allow the Supervisor up to 60 seconds for shutdown. The upstream service grace period is 30 seconds.
- Remove startup write probes and mount details from the App logs.
- Pin the upstream `v26.09.1` image by its multi-architecture digest.
- Prepare experimental App Store packaging and GHCR builds for `amd64` and `aarch64`.

## 0.1.5

- Run the jlesage application account with `USER_ID=0` and `GROUP_ID=0`.
- This matches Home Assistant OS network-share mounts, which are exposed
  locally as `root:root` with `0755` file/directory modes.
- Keep the 0.1.4 output diagnostics for one validation cycle.
- Show the effective App UID/GID in the startup banner.

## 0.1.4

- Add startup diagnostics for `/output/jdownloader`.
- Report UID/GID, directory metadata and relevant Linux mount information.
- Test write access both as root and as the jlesage `app` user.
- No storage behavior is changed in this diagnostic release.

## 0.1.3

- Add an early Home Assistant startup banner showing App version, upstream image,
  platform, Ingress port, storage paths and start time.
- Bake `/ha-app-version` and `/ha-upstream-image` into the image.
- Defensively remove any stale `/etc/cont-init.d/11-ha-ingress.sh` during build,
  so overlaying a new local package cannot retain the obsolete Nginx ACL patch.

## 0.1.2

- Remove the Home Assistant Ingress Nginx ACL patch completely.
- Confirm compatibility with jlesage Nginx, which is built without `http_access_module`.
- Keep port 5800 internal-only; no host/LAN port mapping is configured.
- Keep the TCP healthcheck introduced in 0.1.1.
- Document local `icon.png`, `icon@2x.png`, and `logo.png` placement.

## 0.1.1

- Fix Nginx startup: move Home Assistant Ingress `allow`/`deny` rules from `listen.conf` to the server-context `auth.conf` include.
- Restrict HTTP access strictly to Home Assistant Ingress (`172.30.32.2`).
- Change Docker healthcheck from HTTP localhost to a TCP port check.

## 0.1.0

- Initial local Home Assistant prototype.
- Pinned upstream `jlesage/jdownloader-2:v26.09.1`.
- Direct Home Assistant Ingress on port 5800.
- Persistent `/config` through `addon_config`.
- Home Assistant `/share` mounted on `/output`.
- Default download directory set to `/output/jdownloader`.
- Direct TCP VNC disabled.
- 30-second graceful service shutdown window.
- Custom AppArmor profile included for validation.

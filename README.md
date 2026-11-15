# JDownloader 2 for Home Assistant

[English guide](translation/en.md) · [Guide en français](translation/fr.md)

Run the full **JDownloader 2 desktop** in the Home Assistant sidebar through Ingress. Save downloads locally or to an SMB share mounted by Home Assistant.

[![Add repository to Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fr-jean-pierre%2Fhome-assistant-jdownloader-app)

## Install the App

1. Use the button above, or open **Settings → Apps → Install app → Repositories** in Home Assistant and add this URL.

   ```text
   https://github.com/r-jean-pierre/home-assistant-jdownloader-app
   ```

2. Select **JDownloader 2**, then click **Install** and **Start**.
3. Click **Open Web UI**. Turn on **Show in sidebar** to keep the shortcut.

The App is published as an **experimental** multi-architecture image. The `0.1.6` Store installation and desktop were verified on Home Assistant OS `amd64`. The `aarch64` build passed in CI and runtime testing on an ARM device is pending. See the [changelog](jdownloader/CHANGELOG.md).

## Downloads and settings

| Location | Path |
| --- | --- |
| Download folder in JDownloader | `/output/jdownloader` |
| Download folder in Home Assistant | `/share/jdownloader` |
| Persistent settings and download history in the App | `/config` |

For SMB, mount a Home Assistant network share named `jdownloader` with **Usage** set to **Share**. The [English guide](translation/en.md#use-an-smb-share) and [French guide](translation/fr.md#utiliser-un-partage-smb) show the setup.

## Support and maintenance

- [App documentation in Home Assistant](jdownloader/DOCS.md) covers storage permissions, MyJDownloader and troubleshooting.
- [GitHub Issues](https://github.com/r-jean-pierre/home-assistant-jdownloader-app/issues) is for ordinary bugs and feature requests. For vulnerabilities, follow the [security policy](SECURITY.md).
- [Build and release guide](RELEASING.md) documents the version tag and GHCR publication process.

Maintained by [r-jean-pierre](https://github.com/r-jean-pierre). This independent App uses the [jlesage JDownloader 2 image](https://github.com/jlesage/docker-jdownloader-2). See [LICENSE](LICENSE) for the wrapper and [NOTICE](NOTICE.md) for upstream software and attribution.

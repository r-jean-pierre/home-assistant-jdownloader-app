# JDownloader 2 for Home Assistant

Run the full JDownloader 2 desktop in the Home Assistant sidebar through Ingress. Downloads go to `/share/jdownloader`. A storage share mounted by Home Assistant under that name can serve as the destination.

This is an independent Home Assistant App based on the [jlesage JDownloader 2 image](https://github.com/jlesage/docker-jdownloader-2). The first release is experimental and targets `amd64` and `aarch64`.

## Install

1. In Home Assistant, go to **Settings → Apps → Install app**. Open **Repositories** from the menu and add this repository.
2. Select **JDownloader 2**, then **Install** and **Start**.
3. Select **Open Web UI**. Turn on **Show in sidebar** to keep the shortcut available.

[Add this repository to Home Assistant](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fr-jean-pierre%2Fhome-assistant-jdownloader-app)

See [App documentation](jdownloader/DOCS.md) for storage setup and MyJDownloader. See [releases](RELEASING.md) for the build and publication process.

## Credits

The wrapper, the upstream container, and the software in the image have their own license terms. See [LICENSE](LICENSE) and [NOTICE](NOTICE.md).

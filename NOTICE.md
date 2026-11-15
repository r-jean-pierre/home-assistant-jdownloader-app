# Third-party notices

This repository contains an independent Home Assistant wrapper and installation metadata for JDownloader 2.

- [jlesage/docker-jdownloader-2](https://github.com/jlesage/docker-jdownloader-2/tree/v26.09.1), copyright Jocelyn Le Sage, provides the upstream container and its initialization scripts. Its repository source is under the [MIT license](https://github.com/jlesage/docker-jdownloader-2/blob/v26.09.1/LICENSE). This wrapper changes the default download location and a single output ownership operation in that image.
- [jlesage/docker-baseimage-gui](https://github.com/jlesage/docker-baseimage-gui/tree/v4.14.0) supplies the GUI, including Nginx, noVNC, TigerVNC and Openbox. The pinned base image includes additional upstream packages, with their own license and copyright notices.
- [JDownloader 2](https://jdownloader.org/) is developed by the JDownloader project. The upstream Dockerfile embeds `JDownloader.jar` obtained from JDownloader's installer endpoint. The project publishes [GPLv3 text](https://jdownloader.org/gpl). Determine the terms, notices and corresponding source availability for the specific binary and its bundled components before redistributing the derived image.
- [MyJDownloader](https://my.jdownloader.org/) is an optional external service from JDownloader. The App delegates remote account and service access to JDownloader.
- [Home Assistant](https://www.home-assistant.io/) supplies the Supervisor, App Store and Ingress.

The MIT license in this repository covers the wrapper. The names and marks of other projects belong to their respective owners.

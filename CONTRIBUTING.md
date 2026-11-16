# Contributing to JDownloader 2 for Home Assistant

Contributions to the documentation, English and French guides, and Home Assistant packaging are welcome.

## Choose the right project

This repository maintains the Home Assistant App wrapper, including Ingress, storage, AppArmor, startup configuration, and GitHub Actions. Report issues in the [JDownloader desktop or download engine](https://jdownloader.org/) or the [upstream jlesage container](https://github.com/jlesage/docker-jdownloader-2) to the respective projects.

## Report a bug

Search [existing issues](https://github.com/r-jean-pierre/home-assistant-jdownloader-app/issues) before opening a new one. Include the App and Home Assistant versions, the device architecture (`amd64` or `aarch64`), how to observe the problem, and the expected and actual behavior. For storage issues, say whether the download directory is local or on an SMB share. Remove credentials, personal details, and download URLs containing tokens from any logs or screenshots. Follow [SECURITY.md](SECURITY.md) for vulnerability reports.

## Prepare a pull request

1. Create a branch from `main` and keep the change focused.
2. Update the [App documentation](jdownloader/DOCS.md) and the [English](translation/en.md) and [French](translation/fr.md) guides when the change affects users.
3. Run `git diff --check` and review the Markdown links for documentation changes.
4. Open a pull request targeting `main`. Describe what changed, what you checked, and which checks remain.

Documentation-only changes do not require a new App version. Coordinate App version changes and publication with the maintainer using the [release guide](RELEASING.md).

## Validate App changes

Keep version and digest references consistent when updating the base image. Preserve Home Assistant Ingress, the persistent `/config` volume, and the download mapping from `/output/jdownloader` to `/share/jdownloader`.

For changes to packaging or startup, test installation, **Open Web UI**, and a restart on a Home Assistant test instance. For storage changes, complete a small test download and verify its destination on the Home Assistant host or SMB server. Record the architecture you actually tested. CI runs the App linter and builds both architectures on pull requests. Record runtime validation separately.

## License

Contributions to this wrapper use the repository’s [MIT license](LICENSE). Preserve relevant upstream attributions and [third-party notices](NOTICE.md).

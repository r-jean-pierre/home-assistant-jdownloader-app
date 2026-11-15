# Build and release

## Validate the candidate

- Rebuild the local App on `amd64` and open the desktop through Ingress. Try a browser reload and verify the WebSocket connection stays usable. An HTTP request from another App should return `403`.
- Verify that a small completed download appears on the SMB server. Stop and start the App while a test download is in progress, then verify that the list and download state persist. Check AppArmor in the App information and review the logs for denials.
- Build and start the same candidate on a Home Assistant OS `aarch64` system. Verify Ingress, persistence and a completed download.
- Confirm the proposed MIT license for the wrapper and the rights to the presentation assets. Complete redistribution checks for the pinned image and its bundled binaries using [NOTICE.md](NOTICE.md).

## Publish a version

The build workflow runs the Home Assistant app linter and builds each architecture. GitHub releases to GHCR are triggered by pushing a version tag in the upstream repository. The tag must match `jdownloader/config.yaml`, for example `v0.1.6` for version `0.1.6`.

1. Prepare a release branch containing the intended version and start CI via a pull request. Keep the new Store version on that branch until its image is ready. For a first release, you can push the initial default branch to a private repository and wait for CI there before making the Store repository public.
2. With publication authorized, tag the exact commit you validated.

   ```sh
   git tag v0.1.6
   git push origin refs/tags/v0.1.6
   ```

3. Wait for both architecture builds and the multi-architecture publication job to pass. Make the final `home-assistant-jdownloader-app` package public in GitHub Packages for the first release. On a machine without GHCR credentials, inspect and pull the image for both platforms.

   ```sh
   docker buildx imagetools inspect ghcr.io/r-jean-pierre/home-assistant-jdownloader-app:0.1.6
   docker pull --platform linux/amd64 ghcr.io/r-jean-pierre/home-assistant-jdownloader-app:0.1.6
   docker pull --platform linux/arm64 ghcr.io/r-jean-pierre/home-assistant-jdownloader-app:0.1.6
   ```

4. Make the tested source version available on the default branch. Add the repository in a test Home Assistant instance and install from the App Store.
5. Use a new version and tag for fixes. Version tags identify a single release.

The workflow uses the repository's GitHub token for GHCR and GitHub's identity token for signing. Release jobs build and publish only for the named upstream repository.

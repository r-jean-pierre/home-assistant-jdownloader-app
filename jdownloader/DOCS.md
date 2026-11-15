# JDownloader 2

Start the App and select **Open Web UI**. Home Assistant authenticates the browser session and forwards it through Ingress. Show the App in the sidebar for direct access.

## Downloads and configuration

| Purpose | In JDownloader | In Home Assistant |
| --- | --- | --- |
| Download directory | `/output/jdownloader` | `/share/jdownloader` |
| JDownloader settings and history | `/config` | Configuration folder for this App |

The download path is the default for a new installation. On an existing installation, check **Settings → General → Download Folder** in JDownloader. A package can also have its own destination. The App retains settings and queues through a restart or rebuild.

### SMB storage

1. In Home Assistant, open **Settings → System → Storage → Add network storage**.
2. Set **Name** to `jdownloader` and **Usage** to **Share**. Choose **Samba/Windows (CIFS)**.
3. Enter the SMB server under **Server**, the exported share name under **Remote share**, and the credentials for that export.
4. Start JDownloader. Download a small file and confirm its size on the SMB server after it reaches **Finished** in JDownloader.

The App also works with local storage under `/share/jdownloader`. Check the network storage state in Home Assistant if a finished file is missing on the server. Confirm the destination of the specific JDownloader package and verify that the mount points to the intended share. NFS compatibility requires validation on the target setup.

### CIFS write permissions

In the tested HA OS setup, the mounted volume appears as `root:root` with mode `0755`. This version runs JDownloader as UID/GID `0:0` inside the container so that it can write there. It receives read and write access to Home Assistant's `/share`, mounted as `/output`. The remote SMB permissions are governed by the credentials configured in Home Assistant. The App runs in Docker with an AppArmor profile and the default Home Assistant protection settings.

If JDownloader reports **Invalid download directory**, check the share is mounted, the SMB account can write, and the package targets `/output/jdownloader`. Inspect the App logs for errors around `54-ha-output.sh` and `55-jdownloader2.sh`.

## MyJDownloader and captchas

You can link an existing account in JDownloader's MyJDownloader settings to manage downloads remotely. Some sites require a browser captcha. MyJDownloader and its browser extension can help complete supported challenges on a workstation. Account setup and remote access use the [MyJDownloader service](https://my.jdownloader.org/).

## Ingress or startup errors

If the web interface fails to open, check the App logs for Nginx startup errors and for `all services started`. Open the UI from Home Assistant. The Web server accepts requests through the Supervisor ingress gateway, and VNC TCP is disabled.

When updating, back up the App's configuration. Home Assistant uses a distinct App ID and configuration directory for each repository. The existing local App has ID `local_jdownloader`, and an installation from a GitHub repository will have its own configuration. Plan any transfer of settings while the two instances are stopped to avoid running the same queue twice.

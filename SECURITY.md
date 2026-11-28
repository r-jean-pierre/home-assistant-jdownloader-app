# Security Policy

## Supported versions

Security fixes target the latest published version of the JDownloader 2 Home Assistant App.

## Report a vulnerability privately

Open the [Security advisories page](https://github.com/r-jean-pierre/home-assistant-jdownloader-app/security/advisories) and select **Report a vulnerability** to send a private report. If that button is unavailable, follow the [private contact procedure in the Code of Conduct](CODE_OF_CONDUCT.md#reporting-concerns). Keep vulnerability details in the private channel.

Include the affected App version, Home Assistant version and device architecture, plus a short explanation of what happened and who could be affected. Share only the logs or configuration needed to understand the report, with tokens, credentials and personal data removed.

## Scope

Report issues with the Home Assistant packaging, Ingress configuration, mounted storage, AppArmor profile or build and publication workflows here.

The base image digest pins the software bundled with the container. JDownloader can update its Java software in the persistent `/config` directory while the App is running. An image scan covers the bundled image contents.

For issues in the upstream application or its base container, use the channels of the [JDownloader project](https://jdownloader.org/) or the [jlesage container project](https://github.com/jlesage/docker-jdownloader-2), respectively.

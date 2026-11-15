#!/bin/sh

set -eu

# /output is the Home Assistant /share mapping.
# JDownloader itself uses /output/jdownloader, i.e. /share/jdownloader on HA.
mkdir -p /output/jdownloader

#!/bin/bash
# Install GitHub CLI and classroom extension

set -euo pipefail
IFS=$'\n\t'

# on Archlinux
sudo pacman -S github-cli

gh extension install github/gh-classroom


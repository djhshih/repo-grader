#!/bin/bash
# 

set -euo pipefail
IFS=$'\n\t'

# nvm install 18
nvm use 18
npm install -g @dodona/dolos

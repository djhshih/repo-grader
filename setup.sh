#!/bin/bash
# Download grade table

set -euo pipefail
IFS=$'\n\t'

gh auth login

# obtain repo table
gh classroom assignment-grades -a $CLASS_ID -f submissions.csv

# setup repos
./repos.sh submissions.csv


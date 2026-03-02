#!/bin/bash
# 

set -euo pipefail
IFS=$'\n\t'

repos=$(cat repos.vtr)

for repo in ${repos[@]}; do
	commit/grade.r --format raw --step 0.1 -p repos/$repo
done > commits.vtr


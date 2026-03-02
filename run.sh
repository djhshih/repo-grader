#!/bin/bash
# Run pipeline

set -euo pipefail
IFS=$'\n\t'

# run similarity check
./dolos.sh
Rscript novelty.R

# assess commmit pattern
./commit.sh

# integrate scores
Rscript integrate.R


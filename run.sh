#!/bin/bash
# Run pipeline

set -euo pipefail
IFS=$'\n\t'

# run similarity check
./dolos.sh
Rscript novelty.R

# assess commmit pattern
./commit.sh

# assess prediction
Rscript predict.R

# integrate scores
Rscript integrate.R


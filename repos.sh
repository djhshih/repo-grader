#!/bin/bash
# Setup or update repos

set -euo pipefail
IFS=$'\n\t'

if (( $# < 1 )); then
	echo "usage: ${0##*/} <input>"
	exit 1
fi

out=repos

mkdir -p $out

inpath=$1
infile=${inpath##*/}
infstem=${infile%.*}
outfile=${infstem}.out

cut -d , -f 7 $inpath | sed 1d | sed -E 's|"?.*/(.*)"?|\1|' > repos.vtr

# set up ssh agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# clone or update repo
for repo in $(cat repos.vtr); do
	echo $repo
	if [[ ! -e $out/$repo ]]; then
		git clone $GIT_URL/$repo $out/$repo
	else
		( cd $out/$repo && git pull )
	fi
done


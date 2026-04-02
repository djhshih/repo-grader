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
get_repo() {
	rpath=$1
	lpath=$2
	if [[ ! -e $lpath ]]; then
		git clone $rpath $lpath
	else
		( cd $lpath && git stash && git pull )
	fi
}

git_url=${GIT_BASE_REPO%%/*}
base_repo=${GIT_BASE_REPO##*/}

# get base repo
get_repo $GIT_BASE_REPO $out/$base_repo

# get students' repos
for repo in $(cat repos.vtr); do
	echo $repo
	get_repo $git_url/$repo $out/$repo
done


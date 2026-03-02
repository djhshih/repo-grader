#!/bin/bash
# 

set -euo pipefail
IFS=$'\n\t'

get_paths() {
	prefix=$1
	files=""
	while IFS= read -r path; do
		files+="$prefix/$path/$2 "
	done < repos.vtr
	echo $files
}

mkdir -p job dolos

scripts=$(cat scripts.vtr)

for file in ${scripts[@]}; do
	echo $file
	fstem=${file%.*}
	paths=$(get_paths repos $file)
	rm -rf dolos/$fstem
	echo "dolos run -l r -f csv -o dolos/$fstem $paths" > job/dolos_$fstem.sh
	bash job/dolos_$fstem.sh
done


#!/bin/bash
# Evaluate all repos

# NB  Do not stop on error

out=repos
base_repo=$out/${GIT_BASE_REPO##*/}

# evaluate each repo
for repo in $(cat repos.vtr); do
	echo $repo
	cp $base_repo/{evaluate,production}.* $out/$repo/
	( cd $out/$repo; ./evaluate.sh; ./production.sh $PROD_KEY )
done


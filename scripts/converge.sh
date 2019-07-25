#!/usr/bin/env bash

files_modified="$(git --no-pager diff --name-only master)"
CIRCLE_BRANCH="Adding-Docker-file"
IFS=$'\n'

if [[ ! -z "$CIRCLE_BRANCH" && "$CIRCLE_BRANCH" != "master" ]]; then
	git checkout -q master && git reset  -q --soft origin/master && git checkout -q $CIRCLE_BRANCH && "${files_modified}"
    # echo "${files_modified}"
    for file_name in $files_modified; do
        echo "Line:" "$file_name"
    done
	# if ! (git --no-pager diff --name-only master | grep metadata.rb > /dev/null); then
	# 	echo "It seems like you forgot to update the version number in metadata.rb!"

	# 	exit 1
	# fi
fi




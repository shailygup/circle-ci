#!/usr/bin/env bash

if [[ ! -z "$CIRCLE_BRANCH" && "$CIRCLE_BRANCH" != "master" ]]; then
	git checkout -q master && git reset  -q --soft origin/master && git checkout -q $CIRCLE_BRANCH && git --no-pager diff --name-only master
	# if ! (git --no-pager diff --name-only master | grep metadata.rb > /dev/null); then
	# 	echo "It seems like you forgot to update the version number in metadata.rb!"

	# 	exit 1
	# fi
fi


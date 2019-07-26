#!/usr/bin/env python3

CIRCLE_BRANCH = 'One-more-test'
files_modified="git --no-pager diff --name-only master"

if CIRCLE_BRANCH and CIRCLE_BRANCH != "master":
    git checkout -q master && git reset  -q --soft origin/master && git checkout -q $CIRCLE_BRANCH && files_modified="$(git --no-pager diff --name-only master)"

# 	git checkout -q master && git reset  -q --soft origin/master && git checkout -q $CIRCLE_BRANCH && files_modified="$(git --no-pager diff --name-only master)"
#     if [[ ${files_modified[*]} =~ signalfx ]]; then
#         if [[ ${files_modified[@]} =~ specs || ${files_modified[@]} =~ detectors ]]; then
#             converge_all
#         elif [[ ${files_modified[@]} =~ organizations ]]; then
#             converge_organization
#         fi
#     fi
# fi
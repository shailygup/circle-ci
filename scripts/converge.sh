#!/usr/bin/env bash
declare -a organization_files
# echo "$CIRCLE_SHA1"
# echo "$CIRCLE_BRANCH"
# CIRCLE_BRANCHS="master"
IFS=$'\n'      # Change IFS to new line

converge_organization () {
    for file_name in $files_modified; do
        if [[ $file_name = *"organization"* ]]; then
            organization_files+=("$file_name")
        fi
    done
    if [[ $dry_run == "True" ]]; then
        echo "python cli.py --pd-token 901ff31c40ab4a02ba6a917f02760578 --debug converge --email \"support@cloudreach.com\" --password \"nxICCc%4mJq#9v16\" --dry-run ${organization_files[@]}" 
    else
        echo "python cli.py --pd-token 901ff31c40ab4a02ba6a917f02760578 --debug converge --email \"support@cloudreach.com\" --password \"nxICCc%4mJq#9v16\" ${organization_files[@]}"
    fi
}

converge_all () {
    if [[ $dry_run == "True" ]]; then
        echo "python cli.py --pd-token 901ff31c40ab4a02ba6a917f02760578 --debug converge --email \"support@cloudreach.com\" --password \"nxICCc%4mJq#9v16\" --dry-run" 
    else
        echo "python cli.py --pd-token 901ff31c40ab4a02ba6a917f02760578 --debug converge --email \"support@cloudreach.com\" --password \"nxICCc%4mJq#9v16\" " 
    fi
}

check_signalfx_directories(){
    if [[ ${files_modified[@]} =~ signalfx ]]; then
        if [[ ${files_modified[@]} =~ specs || ${files_modified[@]} =~ detectors ]]; then
            converge_all $dry_run
        elif [[ ${files_modified[@]} =~ organizations ]]; then
            converge_organization $dry_run
        fi
    fi
}

if [[ ! -z "$CIRCLE_BRANCH" && "$CIRCLE_BRANCH" != "master" ]]; then
	git checkout -q master && git reset  -q --soft origin/master && git checkout -q $CIRCLE_BRANCH && files_modified="$(git --no-pager diff --name-only master)"
    dry_run="True"
    check_signalfx_directories $dry_run
elif [[ "$CIRCLE_BRANCH" == "master" ]]; then
    files_modified="$(git --no-pager diff --stat HEAD\^! | grep signalfx | awk '{print $1}')"
    echo "${files_modified[@]}"
    dry_run="False"
    check_signalfx_directories $dry_run
fi
#!/bin/bash

if [ -z "$1" ]
then
    echo "Please provide a commit message"
    exit 1
fi

C_MSG=$1

# making blanket commits across every submodule
git submodule foreach 'git add .'
git submodule foreach "git commit -m $C_MSG"
git submodule foreach 'git push origin HEAD:branch_name'

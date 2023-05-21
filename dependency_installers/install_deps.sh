#!/bin/bash

START=$(pwd)

source ./php.sh
source ./ruby.sh
source ./rust.sh

function reorient() {
    cd $START
    cd ../
}

function call() {
    local setupfunc=$1

    # normalize the calling location for each.
    reorient

    echo "Calling $setupfunc"
    $setupfunc
}

# call all the install functions
call(php)
call(ruby)
call(rust)

#!/bin/bash

# Make sure we're always in the right place, assuming this script is never moved.
RUNSH_PATH=$(realpath "$(dirname "$0")")
cd "$RUNSH_PATH" || exit

CFG_PATH=$(realpath global.conf)

# Stores PIDs of child processes
declare -a pids

function call() {
    cd "$RUNSH_PATH" || exit

    echo "Running $1"
    "$1"

    # most recent backgrounded process
    pids+=("$!")
}

# trap - do this on this signal.
# in this case, we'll kill the PID of every server started in this script
# when the script exits
trap 'kill -9 ${pids[*]}' EXIT

function get_port() {
    crudini --get "$CFG_PATH" "$1" "port"
}

function run_laravel() {
    local laravel_dir="backends/laravel_app/"
    cd "$laravel_dir" || exit

    php artisan serve --port "$(get_port laravel)" &
}

function run_rails() {
    local rails_dir="backends/rails_app/"
    cd "$rails_dir" || exit
    rails server -p "$(get_port rails)" &
}

function run_rocket() {
    # Run rocket/src/main.rs with cargo
    local rocket_dir="backends/rocket_app/"
    cd "$rocket_dir" || exit
    cargo run &
}

function run_flask() {
    # Run flask/src/app.py with flask
    local flask_dir="flask/src/"
    cd "$flask_dir" || exit
    export FLASK_APP="app.py"
    python3 "$FLASK_APP" &
}

function run_c() {
    # make the c backend server
    local c_dir="backends/c_logic/"
    cd "$c_dir" || exit
    make
    ./bin/program "$(get_port c)" &
}

if [ $# -eq 0 ]; then
    echo "No arguments provided, running all backends."

    # Run all the backends.
    ## logic
    call c

    ## renderers
    call laravel
    call rails
    call rocket

    # Run the balancer.
    call flask
else
    echo "Running backends: $*"

    # Run all the backends that the user specified.
    for arg in "$@"; do
        call "run_$arg"
    done
fi

# then wait until sigkill
while true; do
    sleep 5
done

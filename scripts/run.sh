#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
# "$DIR/kill.sh"
cd "$DIR/.."

# Prioritize Release binary for better performance
if [ -f "./target/release/cosmic-edit" ]; then
    ./target/release/cosmic-edit "$@"
elif [ -f "./target/debug/cosmic-edit" ]; then
    ./target/debug/cosmic-edit "$@"
else
    cargo run --release -- "$@"
fi

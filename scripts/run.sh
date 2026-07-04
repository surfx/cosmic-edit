#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR/.."

RELEASE="./target/release/cosmic-edit"
DEBUG="./target/debug/cosmic-edit"

if [[ "$1" == "--release" ]]; then
    shift
    if [ -f "$RELEASE" ]; then
        echo "Running RELEASE binary..."
        exec "$RELEASE" "$@"
    else
        echo "RELEASE binary not found, building and running..."
        cargo run --release -- "$@"
    fi
elif [[ "$1" == "--debug" ]]; then
    shift
    if [ -f "$DEBUG" ]; then
        echo "Running DEBUG binary..."
        exec "$DEBUG" "$@"
    else
        echo "DEBUG binary not found, building and running..."
        cargo run -- "$@"
    fi
else
    # Auto-detect: run the newest binary available
    if [ -f "$RELEASE" ] && [ -f "$DEBUG" ]; then
        if [ "$RELEASE" -nt "$DEBUG" ]; then
            echo "Running newest binary (RELEASE)..."
            exec "$RELEASE" "$@"
        else
            echo "Running newest binary (DEBUG)..."
            exec "$DEBUG" "$@"
        fi
    elif [ -f "$RELEASE" ]; then
        echo "Running RELEASE binary..."
        exec "$RELEASE" "$@"
    elif [ -f "$DEBUG" ]; then
        echo "Running DEBUG binary..."
        exec "$DEBUG" "$@"
    else
        echo "No binary found, building and running DEBUG..."
        cargo run -- "$@"
    fi
fi

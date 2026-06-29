#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Check if user wants release mode
MODE_FLAG=""
if [[ "$1" == "--release" ]]; then
    MODE_FLAG="--release"
    shift # remove --release from args passed to run.sh
else
    echo "Tip: Run './scripts/debug.sh --release' for maximum performance."
fi

echo "Building cosmic-edit..."
if "$DIR/build.sh" $MODE_FLAG; then
    echo "Running cosmic-edit..."
    "$DIR/run.sh" "$@"
else
    echo "Build failed!"
    exit 1
fi

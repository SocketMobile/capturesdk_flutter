#!/usr/bin/env bash -eul
#
#  build script to build the Capture Constants
#
#  The argument should be the path of the project directory
#
# (c) 2019 Socket Mobile, all rights reserved.
#

# Postitional arguments

PROJECT_DIR="${1:-${PWD}}"
BUILD_CONFIG="${2:-Release}"
BUILDSCRIPTS_DIR="$PROJECT_DIR/buildscripts"
python3 "$PROJECT_DIR/tests/tests.py"

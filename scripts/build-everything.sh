#!/usr/bin/env bash

# Fail if anything in here fails
set -e

# This script runs from the project root
THIS_SCRIPT_DIR=$(dirname "$BASH_SOURCE[0]" || dirname "$0")
cd "${THIS_SCRIPT_DIR}/.."

ALL_DIRECTORIES=$(ls -d . demos/*)

source ./scripts/helpers/helpers.sh

###################################################################################################
# Setup

run_command "./scripts/check-environment.sh"

###################################################################################################
# Run all read-write scripts and read-only scripts. This is overkill and duplicates a lot of work,
# but also helps catch intermittent errors. Suitable for running before lunch or teatime.

for DIRECTORY in $ALL_DIRECTORIES ; do
  pushd $DIRECTORY
    run_command "yarn install"
    run_command "yarn all:readonly"
    run_command "yarn all"
  popd
done

###################################################################################################

echo "All builds completed"

#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# `build-workspace.sh` ensures that all packages and demos are up-to-date and passing.
# This covers everything except the framework-tests.

./scripts/check-environment.sh

run_command pnpm install

# Run all read-write scripts and read-only scripts. This is overkill and duplicates a lot of work,
# but also helps catch any intermittent errors. Suitable for running before lunch or teatime.
run_command pnpm run all
run_command pnpm run all:readonly
run_command pnpm run packages:all
run_command pnpm run packages:all:readonly

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

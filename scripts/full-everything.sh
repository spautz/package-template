#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################

echo "Going to doing everything: this will take a while..."
./scripts/clean-everything.sh
source ./scripts/setup-local-environment.sh
run_command "pnpm run all:quick"
run_command "pnpm run packages:all:quick"
run_command "pnpm run clean"
./scripts/build-everything.sh

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

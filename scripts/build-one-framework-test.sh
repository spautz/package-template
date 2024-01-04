#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################

FRAMEWORK_TEST_NAME=$1

./scripts/check-environment.sh
./scripts/setup-one-framework-test.sh $FRAMEWORK_TEST_NAME

run_command pnpm run all
run_command pnpm run all:readonly

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

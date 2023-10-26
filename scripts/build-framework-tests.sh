#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Setup workspace and Yalc

run_command "./scripts/check-environment.sh"
run_command "pnpm install"
run_command "pnpm run packages:yalc-publish"

##################################################################################################
# Setup each framework-test

for DIRECTORY in framework-tests/*/ ; do
  ./scripts/setup-framework-test.sh $(basename "$DIRECTORY")
done

##################################################################################################
# Run checks for each framework-test

for DIRECTORY in framework-tests/*/ ; do
  pushd $DIRECTORY
  echo "Framework-test checks for $DIRECTORY"
  run_command "pnpm run all"
  run_command "pnpm run all:readonly"
  popd
done

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

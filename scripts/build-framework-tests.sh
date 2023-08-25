#!/usr/bin/env bash

# Fail if anything in here fails
set -e

# This script starts from the project root
cd "$(dirname "$0")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Setup workspace and Yalc

run_command "./scripts/check-environment.sh"
run_command "pnpm install"
run_command "pnpm run packages:yalc-publish"

##################################################################################################
# Setup each framework-test

for DIRECTORY in framework-tests/*/ ; do
  pushd $DIRECTORY
  echo "Framework-test setup for $DIRECTORY"
  ../../scripts/setup-framework-test.sh
  popd
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

echo "All framework-tests completed"

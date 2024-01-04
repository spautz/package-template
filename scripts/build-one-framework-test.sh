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
FRAMEWORK_TEST_DIRECTORY="./framework-tests/$FRAMEWORK_TEST_NAME"

if [ -z "$FRAMEWORK_TEST_NAME" ]; then
  echo "Must specify the framework-test to set up"
  exit 1
fi

if [ ! -d "$FRAMEWORK_TEST_DIRECTORY" ]; then
  echo "Invalid framework-test name: \"$FRAMEWORK_TEST_NAME\""
  exit 1
fi

./scripts/check-environment.sh
./scripts/setup-one-framework-test.sh $FRAMEWORK_TEST_NAME

pushd $FRAMEWORK_TEST_DIRECTORY
pnpm run all
pnpm run all:readonly
popd

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

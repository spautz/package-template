#!/usr/bin/env bash

# Ensures that the package imports properly in this environment.
#
# This script assumes the environment has already been set up (node, npm install, etc)

###################################################################################################
# Standard setup for all external-test scripts

SCRIPT_PATH=${BASH_SOURCE[0]:-$0}
EXTERNAL_TEST_DIR=$(cd "$(dirname "$SCRIPT_PATH")" && pwd)
EXTERNAL_TEST_NAME=$(basename "$EXTERNAL_TEST_DIR")
THIS_SCRIPT_NAME=$(basename "$SCRIPT_PATH")

echo "### Begin external-test ${EXTERNAL_TEST_NAME} ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -euo pipefail

# Always run from the external-test dir
pushd "$EXTERNAL_TEST_DIR"

###################################################################################################
# Main body

EXPECTED_OUTPUT="helloWorld: Hello World!"
ACTUAL_OUTPUT=$(node src/import-test.js)

echo "$ACTUAL_OUTPUT"
if [ "$ACTUAL_OUTPUT" != "$EXPECTED_OUTPUT" ]; then
  echo "Unexpected output from import-test.js"
  echo "Expected: $EXPECTED_OUTPUT"
  echo "Actual:   $ACTUAL_OUTPUT"
  exit 1
fi

###################################################################################################
# Standard teardown for all external-test scripts

popd
echo "### End external-test ${EXTERNAL_TEST_NAME} ${THIS_SCRIPT_NAME}"

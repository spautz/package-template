#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the framework-test's directory
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")"

source ../../scripts/helpers/helpers.sh

###################################################################################################

# Ensure the local dir is (reasonly) up-to-date: the base `setup-framework-tests.sh` should have
# handled all environmental setup already
../../node_modules/.bin/yalc update

DEFAULT_ARGS="-p 4173:4173 -p 5173:5173 -v src:/framework-test-bun-vite5/src"

FINAL_ARGS="${*:-$DEFAULT_ARGS}"
run_command docker build . -f ./Dockerfile.framework-test --iidfile ./docker-id.txt
run_command docker run -it $FINAL_ARGS "$(cat ./docker-id.txt)"  bash

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

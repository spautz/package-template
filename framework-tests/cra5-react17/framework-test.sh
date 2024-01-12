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

DOCKERFILE_TARGET="${1:-default}"
source ./framework-test-variables.sh

echo "DOCKERFILE_TARGET=$DOCKERFILE_TARGET"
run_command docker build . -f ./Dockerfile.framework-test --iidfile ./docker-id.txt --build-arg NODE_VERSION=$(cat .nvmrc)  --target $DOCKERFILE_TARGET
run_command docker run $FRAMEWORK_TEST_RUN_ARGS "$(cat ./docker-id.txt)"

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

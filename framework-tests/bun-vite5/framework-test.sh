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

DOCKER_BUILD_TARGET="$1"
EXTRA_ARGS="${*:2}"

# Always rebuild, so that build target may be (optionally) overridden
DOCKER_BUILD_TARGET="$DOCKER_BUILD_TARGET"  run_command     \
  docker compose -f ./docker-compose.framework-test.yaml    \
  up --build --remove-orphans $EXTRA_ARGS                   ;

CONTAINER_ID=$(docker ps -a --filter=name=bun-vite5-main-container --format "{{.ID}}" --last 1)
IMAGE_ID=$(docker images --filter=reference=bun-vite5-main-container --format "{{.ID}}")
echo "CONTAINER_ID=$CONTAINER_ID"
echo "IMAGE_ID=$IMAGE_ID"

# Sync back the lockfile, in case it changed
run_command docker cp $CONTAINER_ID:/framework-test-bun-vite5/bun.lockb ./

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

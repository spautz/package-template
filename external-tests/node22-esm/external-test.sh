#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the external-test's directory
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")"

source ../../scripts/helpers/helpers.sh

###################################################################################################

# Ensure the local dir is (reasonly) up-to-date: the base `update-external-tests.sh` should have
# handled all environmental setup already
../../node_modules/.bin/yalc update

export DOCKER_BUILD_TARGET="$1"
EXTRA_ARGS="${*:2}"

# Always rebuild, so that build target may be (optionally) overridden
run_command docker compose -f ./docker-compose.external-test.yaml                                     \
  up --build --remove-orphans --menu=false --abort-on-container-exit --exit-code-from main-container  \
  $EXTRA_ARGS

CONTAINER_ID=$(docker ps -a --filter=name=node22-esm-main-container --format "{{.ID}}" --last 1)
echo "CONTAINER_ID=$CONTAINER_ID"
IMAGE_ID=$(docker images --filter=reference=node22-esm-main-container --format "{{.ID}}")
echo "IMAGE_ID=$IMAGE_ID"
EXIT_CODE=$(docker inspect $CONTAINER_ID --format='{{.State.ExitCode}}')

# Sync back the lockfile, in case it changed
if [[ $EXIT_CODE -eq 0 ]]; then
  run_command docker cp $CONTAINER_ID:/external-test-node22-esm/package-lock.json ./
else
  exit $EXIT_CODE
fi

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

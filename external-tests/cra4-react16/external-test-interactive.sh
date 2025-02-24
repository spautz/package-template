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

EXTRA_ARGS="$*"

run_command docker compose -f ./docker-compose.external-test.yaml            \
  run --build --service-ports $EXTRA_ARGS                                     \
  main-container  bash                                                        \
  || true;

CONTAINER_ID=$(docker ps -a --filter=name=cra4-react16-main-container --format "{{.ID}}" --last 1)
IMAGE_ID=$(docker images --filter=reference=cra4-react16-main-container --format "{{.ID}}")
echo "CONTAINER_ID=$CONTAINER_ID"
echo "IMAGE_ID=$IMAGE_ID"

# Sync back the lockfile, in case it changed
if [[ $EXIT_CODE -eq 0 ]]; then
  run_command docker cp $CONTAINER_ID:/external-test-cra4-react16/yarn.lock ./
else
  exit $EXIT_CODE
fi

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

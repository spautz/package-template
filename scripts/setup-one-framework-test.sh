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

# Setup workspace and Yalc
run_command "./scripts/check-environment.sh"
pnpm_or_bun install --ignore-scripts
pnpm_or_bun run packages:yalc-publish

pushd $FRAMEWORK_TEST_DIRECTORY

# Set up the framework-test
if [ -f .nvmrc ] ; then
  nvm install $(cat .nvmrc)
  nvm use $(cat .nvmrc)
  corepack enable
fi

# Use workspace's copy of Yalc to copy over any necessary local packages, so that they'll be
# in place when we try to install
../../node_modules/.bin/yalc update
pnpm_or_bun install

popd

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"
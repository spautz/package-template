#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

###################################################################################################

FRAMEWORK_TEST_NAME=$1
FRAMEWORK_TEST_DIRECTORY="./framework-tests/$FRAMEWORK_TEST_NAME"

if [ -z "$FRAMEWORK_TEST_NAME" ]; then
  echo "Must specify the framework-test to set up"
  exit 1
fi

if [ ! -d "$FRAMEWORK_TEST_DIRECTORY" ]; then
  echo "Invalid framework-test: \"$FRAMEWORK_TEST_NAME\""
  exit 1
fi

cd $FRAMEWORK_TEST_DIRECTORY

# Set up the framework-test

if [ -f .nvmrc ] ; then
  nvm install $(cat .nvmrc)
  nvm use $(cat .nvmrc)
fi

corepack enable

pnpm dlx yalc update
pnpm install

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

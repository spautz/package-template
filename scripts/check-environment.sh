#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Check versions of Node, pnpm, and any other tools required

# If "engines" is set in package.json, validate against its values
HAS_ENGINES=$(get_json_value package.json "engines")
if [ $HAS_ENGINES ]; then
  run_npm_command check-node-version --package --print
else
  echo "No \"engines\" declared in package.json!"
  exit 1
fi


if ! command_exists pnpm; then
  echo "Could not find pnpm!"
  exit 1
fi

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

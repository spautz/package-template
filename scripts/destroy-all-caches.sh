#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Clean everything local first -- and again at the end

./scripts/clean-everything.sh


if command_exists jest; then
  run_npm_command jest --clearCache
fi

if command_exists pnpm; then
  run_command "rm -rf $(pnpm store path)"
fi

if command_exists yarn; then
  run_command "yarn cache clean --all"
fi

run_command npm cache clean --force


./scripts/clean-everything.sh

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

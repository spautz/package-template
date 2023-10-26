#!/usr/bin/env bash

THIS_SCRIPT_NAME=$(basename "$0")
echo "### Begin ${THIS_SCRIPT_NAME}"

# Fail if anything in here fails
set -e
# Run from the repo root
pushd "$(dirname -- "${BASH_SOURCE[0]:-$0}")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################

# on Windows `nvm` will be a real command; on other environments -- with "real" nvm -- it's just a function
if ! command_exists nvm; then
  NVM_INIT="$HOME/.nvm/nvm.sh"
  if [ -f $NVM_INIT ]; then
    source $NVM_INIT
  else
    echo "Could not find nvm!"
    exit 1
  fi
fi

# Must include .nvmrc content manually to support all platforms
run_command "nvm install $(cat .nvmrc)"
run_command "nvm use $(cat .nvmrc)"

run_command "corepack enable"

if ! command_exists pnpm; then
  echo "Could not find pnpm!"
  exit 1
fi

run_command "./scripts/check-environment.sh"
run_command "pnpm install --frozen-lockfile --ignore-scripts"
run_command "pnpm clean"
run_command "pnpm install --frozen-lockfile --offline"

###################################################################################################

popd
echo "### End ${THIS_SCRIPT_NAME}"

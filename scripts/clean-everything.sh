#!/usr/bin/env bash

# Fail if anything in here fails
set -e

# This script runs from the project root
cd "$(dirname "$0")/.."

source ./scripts/helpers/helpers.sh

###################################################################################################
# Halt running processes and local servers

if command_exists killall; then
  run_command killall -v node || true
fi

if command_exists watchman; then
  run_command watchman watch-del-all
fi

##################################################################################################
# Clear caches

if [ -d "./node_modules/" ]; then
  run_command pnpm run clean
fi

if command_exists pnpm; then
  run_command "pnpm store prune" || true
fi

run_command "rm -rf
  $TMPDIR/react-*
  "

##################################################################################################
# Remove generated files

for DIRECTORY in '.' 'demo-apps/*' 'test-apps/*' 'packages/*' ; do
  run_command "rm -rf
    $DIRECTORY/.yarn
    $DIRECTORY/build/
    $DIRECTORY/coverage/
    $DIRECTORY/coverage-local/
    $DIRECTORY/dist/
    $DIRECTORY/legacy-types/
    $DIRECTORY/lib-dist/
    $DIRECTORY/node_modules/
    $DIRECTORY/storybook-static/
    $DIRECTORY/*-debug.log*
    $DIRECTORY/.*-debug.log*
    $DIRECTORY/*-error.log*
    $DIRECTORY/.*-error.log*
    "
done

REMAINING_FILES=$(git clean -xdn)
if [[ $REMAINING_FILES ]]; then
  echo "Ignored files left:"
  echo "$REMAINING_FILES"
fi;

###################################################################################################

echo "Environment reset completed"

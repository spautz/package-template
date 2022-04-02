#!/usr/bin/env bash

# Fail if anything in here fails
set -e

# This script runs from the project root
THIS_SCRIPT_DIR=$(dirname "$BASH_SOURCE[0]" || dirname "$0")
cd "${THIS_SCRIPT_DIR}/.."

ALL_DIRECTORIES=$(ls -d . demos/*)

source ./scripts/helpers/helpers.sh

###################################################################################################
# Halt running processes and local servers

if command_exists killall; then
  run_command killall -v node || true
fi

if command_exists xcrun; then
  run_command xcrun simctl shutdown all || true
fi

##################################################################################################
# Clear caches

for DIRECTORY in $ALL_DIRECTORIES ; do
  pushd $DIRECTORY
    if [ -d "./node_modules/" ]; then
      run_command yarn clean
    fi
  popd
done


if [ -d "./node_modules/" ]; then
  run_npm_command jest --clearCache
else
  run_npm_command jest --clearCache --config={}
fi

if command_exists yarn; then
  run_command yarn cache clean
fi

run_command npm cache clean --force

if command_exists watchman; then
  run_command watchman watch-del-all
fi

run_command "rm -rf
  $TMPDIR/react-*
  "

##################################################################################################
# Remove generated files

for DIRECTORY in $ALL_DIRECTORIES ; do
  run_command "rm -rf
    $DIRECTORY/.yarn
    $DIRECTORY/build/
    $DIRECTORY/coverage/
    $DIRECTORY/dist/
    $DIRECTORY/legacy-types/
    $DIRECTORY/lib-dist/
    $DIRECTORY/node_modules/
    $DIRECTORY/storybook-static/
    $DIRECTORY/lerna-debug.log*
    $DIRECTORY/npm-debug.log*
    $DIRECTORY/yarn-debug.log*
    $DIRECTORY/yarn-error.log*
    "
done

REMAINING_FILES=$(git clean -xdn)
if [[ $REMAINING_FILES ]]; then
  echo "Ignored files left:"
  echo "$REMAINING_FILES"
fi;

###################################################################################################

echo "Environment reset completed"

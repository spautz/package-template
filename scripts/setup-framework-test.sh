#!/usr/bin/env bash

# Fail if anything in here fails
set -e

###################################################################################################

# Unlike other scripts, this must be run from within the desired framework-test's directory:
# it does not set the directory itself
pwd

if [ -f .nvmrc ] ; then
  nvm install $(cat .nvmrc)
  nvm use $(cat .nvmrc)
fi;

corepack enable

pnpm dlx yalc update
pnpm install;

###################################################################################################

echo "Framework-test setup complete"

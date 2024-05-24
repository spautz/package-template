#!/usr/bin/env node

import path from 'node:path';
import { readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';

import { globSync } from 'glob';
import every from 'lodash/every.js';
import get from 'lodash/get.js';
import matches from 'lodash/matches.js';
import merge from 'lodash/merge.js';
import set from 'lodash/set.js';
import some from 'lodash/some.js';
import unset from 'lodash/unset.js';
import yargs from 'yargs/yargs';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

// import workspaceModeSettings from './workspace-modes.json' assert { type: 'json' };

const workspaceModeSettings = JSON.parse(
  readFileSync(path.join(__dirname, 'workspace-modes.json')),
);

const availableModes = Object.keys(workspaceModeSettings.modes);

///////////////////////////////////////////////////////////////////////////////
// Support functions

function objectHasValues(obj, path, valuesToMatch) {
  return every(get(obj, path), matches(valuesToMatch));
}

function objectHasAnyKeys(obj, path, keysToAvoid) {
  if (Array.isArray(keysToAvoid)) {
    keysToAvoid = [keysToAvoid];
  }

  return !some(get(obj, path), matches(valuesToMatch));
}

function mergeIntoObject(obj, path, valuesToMerge) {
  return merge(obj, set({}, path, valuesToMerge));
}

function removeFromObject(obj, path, keysToRemove) {
  if (!Array.isArray(keysToRemove)) {
    keysToRemove = [keysToRemove];
  }

  keysToRemove.forEach((key) => {
    unset(get(obj, path), key);
  });
  return obj;
}

function setPackageToMode(packageJsonContent, modeSettings) {
  if (modeSettings.addEntryPoints) {
    packageJsonContent = mergeIntoObject(
      packageJsonContent,
      'exports',
      modeSettings.addEntryPoints,
    );
  }
  if (modeSettings.removeEntryPoints) {
    packageJsonContent = removeFromObject(
      packageJsonContent,
      'exports',
      modeSettings.removeEntryPoints,
    );
  }
  if (modeSettings.setImportMap) {
    packageJsonContent = mergeIntoObject(packageJsonContent, 'imports', modeSettings.setImportMap);
  }
  if (modeSettings.clearImportMap) {
    packageJsonContent = removeFromObject(
      packageJsonContent,
      'imports',
      modeSettings.clearImportMap,
    );
  }
  return packageJsonContent;
}

// eslint-disable-next-line @typescript-eslint/no-unused-vars
function comparePackageToMode(packageJson, modeSettings) {
  if (
    modeSettings.addEntryPoints &&
    !objectHasValues(packageJson, 'exports', modeSettings.addEntryPoints)
  ) {
    return false;
  }
  if (
    modeSettings.removeEntryPoints &&
    objectHasAnyKeys(packageJsonContent, 'exports', modeSettings.removeEntryPoints)
  ) {
    return false;
  }

  if (
    modeSettings.setImportMap &&
    !objectHasValues(packageJson, 'imports', modeSettings.setImportMap)
  ) {
    return false;
  }
  if (
    modeSettings.clearImportMap &&
    objectHasAnyKeys(packageJsonContent, 'imports', modeSettings.clearImportMap)
  ) {
    return false;
  }

  return true;
}

///////////////////////////////////////////////////////////////////////////////
// Command entry points

function setModeCommandFn(argv) {
  const { name } = argv;
  const modeSettings = workspaceModeSettings.modes[name];

  console.log('setModeCommandFn()', { name, modeSettings });

  Object.entries(modeSettings).forEach(([pathGlob, projectSettings]) => {
    const projectPaths = globSync(pathGlob, { cwd: __dirname });

    console.log('  path and settings: ', {
      pathGlob,
      projectPaths,
      projectSettings,
    });

    projectPaths.forEach((projectPath) => {
      const packageJsonPath = path.join(projectPath, 'package.json');
      const packageJsonContent = JSON.parse(readFileSync(packageJsonPath).toString());

      const newContent = setPackageToMode(packageJsonContent, projectSettings);
      writeFileSync(packageJsonPath, JSON.stringify(newContent, null, 2));
    });
  });
}

function statusCommandFn(argv) {
  console.log('this is the status command');
}

function validateModeCommandFn(argv) {
  const { name } = argv;

  console.log('this is the validate command');
  if (name) {
    console.log('  name = ', name);
  }
}

///////////////////////////////////////////////////////////////////////////////
// Main entry point

const argv = yargs(process.argv.slice(2))
  .command(
    ['set-mode <name>', '$0'],
    'switch workspace packages to match a workspace mode',
    (yargs) => {
      yargs
        .positional('name', {
          describe: 'identifier for the mode, defined in workspace-modes.json',
          type: 'string',
        })
        .choices('name', availableModes);
    },
    setModeCommandFn,
  )
  .command(
    'status',
    'display the current workspace mode',
    () => {
      // No options
    },
    statusCommandFn,
  )
  .command(
    'validate [name]',
    'ensure that workspace currently matches the specified workspace mode (or any mode, if none is specified)',
    (yargs) => {
      yargs
        .positional('name', {
          describe: 'identifier for the mode, defined in workspace-modes.json',
          type: 'string',
        })
        .choices('name', availableModes);
    },
    validateModeCommandFn,
  )
  .parse();

console.log('argv = ', argv);

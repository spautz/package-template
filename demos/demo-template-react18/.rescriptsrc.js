const path = require('path');
const resolveFrom = require('resolve-from');

const packageJson = require('./package.json');

function addAliasForLocalPackage(packageName) {
  try {
    const aliasName = `${packageName}\$`;
    if (!aliases[aliasName]) {
      aliases[aliasName] = resolveFrom(path.resolve('node_modules'), packageName);
    }
  } catch (e) {
    // It's ok if we can't resolve: @types and bin packages (like react-scripts) don't have a main import
  }
}

// ================================================================================================

const aliases = {
  'package-template$': resolveFrom(path.resolve('../..'), '.'),
};

Object.keys(packageJson.dependencies).map(addAliasForLocalPackage);
Object.keys(packageJson.devDependencies).map(addAliasForLocalPackage);

// Based on https://gist.github.com/tannerlinsley/4778cf30d66530ea9802899168119ec0
const fixLinkedDependencies = (config) => {
  config.resolve = {
    ...config.resolve,
    alias: {
      ...config.resolve.alias,
      ...aliases,
    },
  };
  return config;
};

const allowOutsideSrc = (config) => {
  config.resolve.plugins = config.resolve.plugins.filter(
    (p) => p.constructor.name !== 'ModuleScopePlugin',
  );
  return config;
};

module.exports = [fixLinkedDependencies, allowOutsideSrc];

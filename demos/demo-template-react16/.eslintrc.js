/* eslint-env node */

// Trying to extend the root config through eslint (via "extends") fails because modules conflict between different
// locations, but when we simply duplicate the config everything works as expected.
// eslint-disable-next-line @typescript-eslint/no-var-requires
const rawEslintConfig = require('../../.eslintrc.js');

module.exports = {
  ...rawEslintConfig,
};

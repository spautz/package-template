/* eslint-env node */

module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended', 'prettier'],

  rules: {},
  overrides: [
    {
      files: ['**/*.test.*', '**/tests/*.*'],
      env: {
        jest: true,
      },
    },
  ],

  ignorePatterns: [
    'build/',
    'coverage/',
    'dist/',
    'legacy-types/',
    'lib-dist/',
    'node_modules/',
    'storybook-static/',
  ],
};

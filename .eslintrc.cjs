/* eslint-env node */

module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    /* 'react-app', */ 'prettier',
  ],

  rules: {
    '@typescript-eslint/no-unused-vars': [
      'error',
      {
        argsIgnorePattern: '^_',
        varsIgnorePattern: '^_',
      },
    ],
    /* 'react/jsx-uses-react': 'error', */
    /* 'react/jsx-uses-vars': 'error', */
  },
  overrides: [
    {
      // Allow `require` in CommonJS files
      files: ['**/*.cjs'],
      rules: {
        '@typescript-eslint/no-var-requires': 'off',
      },
    },
    /* {
        files: ['**\/*.jsx', '**\/*.tsx'],
       plugins: ['@typescript-eslint', 'react'],
       extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended', 'react-app', 'prettier'],
       rules: {
         'react/jsx-uses-react': 'error',
         'react/jsx-uses-vars': 'error',
       },
     }, */
  ],

  ignorePatterns: [
    '!.storybook/',
    'build/',
    'coverage/',
    'coverage-local/',
    'dist/',
    'legacy-types/',
    'lib-dist/',
    'node_modules/',
    'storybook-static/',
    // Each framework-test has its own eslint config, following the conventions of its framework, so they're not included
    'framework-tests/',
  ],
};

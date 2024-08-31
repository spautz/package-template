import { configDefaults, defineConfig } from 'vitest/config';

// Check each package and demo
const testPathsToExclude = [
  ...configDefaults.exclude,
  '**/coverage/**',
  '**/legacy-types/**',
  '**/setupTests.ts',
  'docs-website/**',
  // Each external-test has its own test config, following the conventions of its framework, so they're not included
  'external-tests/**',
];

export default defineConfig({
  test: {
    environment: 'jsdom',

    // This gets resolved *per project* (each package, plus the root)
    setupFiles: './setupTests.ts',

    exclude: testPathsToExclude,

    coverage: {
      provider: 'v8',
      exclude: [...(configDefaults.coverage.exclude || []), ...testPathsToExclude],
      reporter: ['html', 'lcov'],
    },
  },
});

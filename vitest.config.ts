import { configDefaults, defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'jsdom',

    // This gets resolved *per project* (each package, plus the root)
    setupFiles: './setupTests.ts',

    // Check each package and demo-app
    // Each test-app has its own test config, following the conventions of its build system
    exclude: [...configDefaults.exclude, 'test-apps/**'],

    coverage: {
      provider: 'c8',
      exclude: [
        ...configDefaults.exclude,
        ...(configDefaults.coverage.exclude || []),
        '**/legacy-types/**',
      ],
      reporter: ['html', 'lcov'],
    },
  },
});

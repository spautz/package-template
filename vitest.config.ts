import { configDefaults, defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'jsdom',

    // This gets resolved *per project* (each package, plus the root)
    setupFiles: './setupTests.ts',

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

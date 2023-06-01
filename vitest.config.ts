import { configDefaults, defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'jsdom',

    // TEMPORARY:
    exclude: [...configDefaults.exclude, 'demos/demo-react16-cra/**', 'demos/demo-react17-cra/**'],

    // This gets resolved *per project* (each package, plus the root)
    setupFiles: './setupTests.ts',

    coverage: {
      provider: 'c8',
      exclude: [
        ...configDefaults.exclude,
        ...(configDefaults.coverage.exclude || []),
        '**/__tests__/**',
        '**/legacy-types/**',
      ],
      reporter: ['html', 'lcov'],
    },
  },
});

import { defineConfig } from 'vitest/config';

export default defineConfig({
  test: {
    environment: 'jsdom',

    setupFiles: './setupTests.ts',

    coverage: {
      provider: 'v8',
      reporter: ['html', 'lcov'],
    },
  },
});

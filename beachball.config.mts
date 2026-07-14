import type { BeachballConfig } from 'beachball';

// https://microsoft.github.io/beachball/overview/configuration.html#options
import { createRenderEntry } from './scripts/changelog/beachball-change-format.ts';

const beachballConfig: BeachballConfig = {
  branch: 'main',
  access: 'public',
  defaultNpmTag: 'next',
  bumpDeps: true,
  commit: false,
  changehint: 'Use `pnpm run changelog` to add a changelog entry.',
  groupChanges: true,
  ignorePatterns: [
    '**/__tests__/**',
    '**/*.test.*',
    '**/*.ignored.*',
    '**/setupTests.ts',
    '**/vitest.config.ts',
  ],
  changelog: {
    customRenderers: {
      renderEntry: createRenderEntry(),
    },
  },
};

export default beachballConfig;

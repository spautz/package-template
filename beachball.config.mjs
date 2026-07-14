// import type { BeachballConfig } from 'beachball';

// https://microsoft.github.io/beachball/overview/configuration.html#options
const beachballConfig = {
  branch: 'main',
  access: 'public',
  defaultNpmTag: 'next',
  bumpDeps: true,
  commit: false,
  changehint: 'Use `pnpm run changelog` to add a changelog entry.',
  groupChanges: true,
};

export default beachballConfig;

// @ts-nocheck

const env = import.meta?.env || process.env;

const skipTheBuildSettings = {
  // When enabled, apps will *directly consume* packages' source code,
  // instead of going through the package's `dist/`.
  // This is orders of magnitude faster for local dev, but it can conceal
  // mistakes because it's not how real packages work.
  // By default it's enabled for local dev and disabled for CI.
  whenToSkip: {
    // @TODO: Fix/integrate skip-the-build package
    default: env.SKIP_THE_BUILD == null ? !env.CI : env.SKIP_THE_BUILD,
  },
  settings: {
    importConditionName: 'local-dev',
  },
} as const;

export default skipTheBuildSettings;

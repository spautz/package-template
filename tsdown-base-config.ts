import { defineConfig, type UserConfig } from 'tsdown';

const tsdownEntryDefaults: Partial<UserConfig> = {
  entry: ['src/index.ts'],
  dts: true,
};

const tsdownBaseConfigValues: Array<UserConfig> = [
  {
    ...tsdownEntryDefaults,
    format: 'esm',
    outDir: './dist/esm',
    tsconfig: './tsconfig.build-esm.json',
    // ESM gets .js extensions instead of .mjs
    fixedExtension: false,
  },
  {
    ...tsdownEntryDefaults,
    format: 'cjs',
    outDir: './dist/cjs',
    tsconfig: './tsconfig.build-cjs.json',
  },
];

const tsdownBaseConfig: Array<UserConfig> = defineConfig(tsdownBaseConfigValues);

export default tsdownBaseConfig;
export { tsdownBaseConfig, tsdownBaseConfigValues, tsdownEntryDefaults };

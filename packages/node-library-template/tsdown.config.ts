import { defineConfig } from 'tsdown';

const defaults = {
  entry: ['src/index.ts'],
  dts: true,
};

export default defineConfig([
  {
    ...defaults,
    format: 'esm',
    outDir: './dist/esm',
    tsconfig: './tsconfig.build-esm.json',
    // ESM gets .js extensions instead of .mjs
    fixedExtension: false,
  },
  {
    ...defaults,
    format: 'cjs',
    outDir: './dist/cjs',
    tsconfig: './tsconfig.build-cjs.json',
  },
]);

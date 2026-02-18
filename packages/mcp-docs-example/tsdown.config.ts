import { defineConfig, type UserConfig } from 'tsdown';
import { baseConfigValues } from '../../tsdown-base-config.ts';

const mcpConfig: UserConfig = defineConfig({
  ...baseConfigValues,
  entry: ['src/cli.ts', 'src/mcp-server.ts'],
  format: 'esm',
  outDir: './dist',
  platform: 'node',
  dts: false,
  // ESM gets .js extensions instead of .mjs
  fixedExtension: false,
  tsconfig: './tsconfig.build-esm.json',
});

export default mcpConfig;

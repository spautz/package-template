import { defineConfig, type UserConfig } from 'tsdown';

const mcpConfig: UserConfig = defineConfig({
  entry: ['src/mcp/cli.ts', 'src/mcp/server.ts'],
  format: 'esm',
  outDir: './dist/mcp',
  platform: 'node',
  dts: false,
  // ESM gets .js extensions instead of .mjs
  fixedExtension: false,
  tsconfig: './tsconfig.build-esm.json',
});

export default mcpConfig;

import { defineConfig, type UserConfig } from 'vite';

const viteConfig: UserConfig = defineConfig({
  build: {
    sourcemap: true,
    rollupOptions: {
      // overwrite default .html entry
      input: 'src/index.ts',
    },
  },
});

export default viteConfig;

import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    sourcemap: true,
    rollupOptions: {
      // overwrite default .html entry
      input: 'src/index.ts',
    },
  },
});

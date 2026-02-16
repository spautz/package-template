import { withSkipTheBuild } from '@skip-the-build/vite';
import type { UserConfig } from 'vite';

import skipTheBuildConfig from '../../skip-the-build.ts';

const viteConfig: UserConfig = await withSkipTheBuild(skipTheBuildConfig, {
  build: {
    sourcemap: true,
  },
});

export default viteConfig;

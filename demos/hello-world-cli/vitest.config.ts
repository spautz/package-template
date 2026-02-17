import { mergeConfig, type UserConfig } from 'vite';

import baseVitestConfig from '../../vitest.config.js';
import viteConfig from './vite.config.js';

const vitestConfig: UserConfig = mergeConfig(viteConfig, baseVitestConfig);

export default vitestConfig;

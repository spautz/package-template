import { defineConfig, type UserConfig } from 'vite';
import skipTheBuildSettings from '../../skip-the-build.ts';

// @TODO: Fix/integrate skip-the-build package
const customImportConditions = ['import', 'default'];
if (skipTheBuildSettings.whenToSkip.default) {
  customImportConditions.unshift(skipTheBuildSettings.settings.importConditionName);
}

const viteConfig: UserConfig = defineConfig({
  build: {
    sourcemap: true,
  },
  resolve: {
    conditions: customImportConditions,
  },
});

export default viteConfig;

export default {
  hooks: {
    beforePacking(pkg) {
      // biome-ignore-all lint/performance/noDelete: Remove development-only fields
      delete pkg.devDependencies;
      delete pkg.scripts;
      delete pkg['size-limit'];

      // Add publication metadata
      pkg.publishedAt = new Date().toISOString();

      return pkg;
    },
  },
};

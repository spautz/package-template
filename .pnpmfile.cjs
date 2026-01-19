// biome-ignore-all lint/performance/noDelete: Delete to avoid publishing unnecessary fields

module.exports = {
  hooks: {
    beforePacking(pkg) {
      // Remove development-only fields
      delete pkg.devDependencies;
      delete pkg.scripts;
      delete pkg['size-limit'];

      // Add publication metadata
      pkg.publishedAt = new Date().toISOString();

      return pkg;
    },
  },
};

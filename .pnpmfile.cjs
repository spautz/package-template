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

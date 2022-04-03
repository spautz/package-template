/* eslint-env node */

module.exports = {
  preset: 'ts-jest',
  roots: [
    '<rootDir>/src/',
    '<rootDir>/demos/demo-template-react16/src',
    '<rootDir>/demos/demo-template-react17/src',
    '<rootDir>/demos/demo-template-react18/src',
  ],
  testEnvironment: 'jsdom',
  testPathIgnorePatterns: ['/__tests__/_.*', '/node_modules/'],

  setupFilesAfterEnv: ['<rootDir>/src/setupTests.ts'],

  collectCoverage: true,
  coverageReporters: ['json', 'html', 'lcov'],
};

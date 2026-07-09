# External-Test: Node 22 with npm, resolving CJS

This is a small test project that exercises this repo's packages in a simple script.
It's primarily used for CI checks, but it's also a full working demo that you can run locally.

It runs in its own Docker container:

1. The Docker sets up a clean, empty git repo
2. `external-test-checks.sh` runs `src/import-test.js`, which runs a quick check

To run locally:
```bash
scripts/run-external-test.sh  node22-cjs
```

or, to get a shell and play around on your own:
```bash
scripts/run-external-test-interactive.sh  node22-cjs
```

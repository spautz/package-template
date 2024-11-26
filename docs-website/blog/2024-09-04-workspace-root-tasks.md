---
-sidebar_position: 2
-slug: workspace-root-tasks
-title: Workspace Root Tasks
-authors: [spautz]
-tags: [package-workspace, philosophy]
---

# Workspace Root Tasks

## Summary

- In a package workspace, it's often useful to have workspace-level tasks which run package-level checks at a wider
  scope.
- When migrating the workspace to Turborepo, those use cases evaporate: individual package-level checks are enough.
- You can further optimize things by migrating configs into local packages, but it's not worth the effort for most
  projects.

## Background and Context

In a package workspace (i.e., a monorepo setup for developing npm packages), npm scripts typically fall into two
categories:

- Tasks for an individual package: building, running tests, etc
- Tasks for the repo or workspace itself: git hooks, publishing workflows, etc

For example:

```
// Root package.json
"changelog:status": "changeset status --verbose",
"format": "prettier --write .",
"publish:docs": "pnpm run --filter=docs-website deploy",
```

```
// A library's package.json
"build": "tsc -p tsconfig.build-esm.json",
"test": "vitest run --coverage",
"typecheck": "tsc --noEmit",
```

Additionally, it's useful to have some root tasks which overlap the package-level tasks, such as:

- Running all packages' builds in dependency order
- Running all packages' tests together, with a single code coverage report
- Running lint or typecheck against config files at the repo root

For example:

```
// Root package.json
"packages:build": "pnpm run -r build",
"test": "vitest run --coverage",
"typecheck": "tsc --noEmit",
```

Two of those commands (`vitest` and `tsc` at the repo level) are the same command as their package-level equivalents:
they just use a different config. The Vitest or Typescript config at the root will target files in all packages, in
addition to any relevant files which don't live in a particular package.

The above setup yields a lot of individual npm scripts, but I've found it to offer a good balance between power and
flexibility, particularly for local dev.

### A Deeper Dive into Overlapping Tasks

Three specific package-level scripts can make sense as root-level scripts run with a different config:

- Linting
  - Faster to run `eslint` once, instead of once per package
  - Run checks against files that aren't in any package, like base configs
- Unit Tests
  - Faster to run `vitest` once, instead of once per package
  - Easy to generate a single code coverage report for the entire repo
- Typechecking
  - Faster to run `tsc` once, instead of once per package
  - Run checks against files that aren't in any package, like base configs

Depending on the repo, the "Faster to run once" option can be 5x as fast as running the script once per package.

That is to say: `vitest run --coverage` at the repo level (running all tests in all projects as a single suite) may run
in 1/5 the time as a `pnpm -r run test`. So, these 'overlapping' tasks are well worth the extra effort to configure.

## Enter Turborepo

[Turborepo](https://turbo.build/repo/docs) adds caching for commands. Instead of running `tsc` every time the build
script is run, it may be configured to only run when the build's inputs have changed: source files, build config, etc --
and to reuse the previously-cached output otherwise.

Skipping that work changes the performance savings of the "Faster to run once" options above:

...
...
...

There can be overlap between those categories: some package-level dev tools can also be done at the repo level --
either to run as a single task (instead of one task per package), or to check files which are not part of any project
(like repo-level config files).

For example:

- Unit tests may be run over all projects together, in a single run. This can be much faster than running tests
  individually for each project. In this demo/template repo, `pnpm run test` at the workspace levels runs in 1/5
  the time as a `pnpm -r run test` (to run in each package, excluding the workspace)
- Type-checking each individual project works well, but it does not cover files at the repo root, like `setupTests.ts`
  and `vite.config.ts`. An additional command must be run to ensure those files' typings are correct.

---

Format

- Always root-level
- Needs to depend on all not-gitignored files
- Is it even worth caching?

Lint

- Always package-level?
  - except for configs themselves
  - root-level would need to depend on all packages' src/ + configs

Test

- Need to decide: is root-level useful?
-

Typecheck

- Same setup/concerns as Lint? Packages + configs

---

-
- So, either:
  - A) Run root-level for configs, then all packages
  - B) Run for all packages, with configs in a package
  - Rejected: (C) Root level _encompasses_ all packages
- Doing things in a package means 'build' won't rerun just because 'eslint.config.js' changed
  - but is this really a big concern?
  - by default, 'build' would still be affected by eslint changes, since tsconfig would be in the same project. So do we
    just split everything up by script? That feels needless.
  - Also: the root config file still exists (it just extends the package ... so _changes_ are segmented off even if
    _file existence_ isn't)
- Scenarios for individual file updates:
  - /package.json: all scripts for all packages
  - eslint config:
    - A) all scripts for all packages
    - B) all config-affected scripts for all packages... which is all scripts
  - typescript base config:
    to somethi
    ..

So what this question _really_ becomes is: can/should we remove the root scripts?

- The ones that _encompass_ all packages: yes. The old argument was speed, but that argument is gone now.
- Ones that check configs: we need a separate run at the root level first (e.g., `//#lint` followed by `lint`)
  - Alternative: each package's `lint` depends on `local-dev-configs:lint`
    - ... wait: this means "all config-affected scripts" does NOT mean all scripts!
      - lint depends on lint
      - test depends on ...need a dummy test
      - build depends on ... everything in `local-dev-configs` should depend on build, I think?
-

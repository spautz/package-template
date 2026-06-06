# Changelog

This repo uses [Changesets](https://github.com/changesets/changesets) to manage the Changelog, using the
[changesets-format-with-git-links](https://github.com/spautz/changesets-changelog-format) format.

Commands:

- `pnpm run changelog` to add a changelog entry
- `pnpm run changelog:status` to view pending changes
- `pnpm run release:prepare` to update the changelog
- `pnpm run release:stage:dry-run` to preview staged publishing for `./packages/*`
- `pnpm run release:stage` to stage `./packages/*` for npm release approval

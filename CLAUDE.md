# CLAUDE.md

## Linting & Formatting

**Biome** replaces ESLint and Prettier. Use `biome check --write` to auto-fix.

## Testing

`mcp-docs-example` test scripts are **intentionally disabled** (`_DISABLED` suffix) — not a bug.

## External Tests Are Isolated

`external-tests/` has its own workspace config and is not governed by root Biome or Turbo. Root config changes don't apply there.

## Build & Size Limits

`pnpm run build` in a package chains: clean → compile → `publint --strict` + `size-limit`. Size budgets are strict — code changes can fail even if tests pass.

## Local Dev (skip-the-build)

Demos use a `"local-dev"` export condition that bypasses `dist/` and points to `src/` directly. Build problems won't surface in this mode.

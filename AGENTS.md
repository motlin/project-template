# Project Template

Language-agnostic base template. Derived templates (typescript, rust, java, playdate) copy these files and extend them; `.claude/commands/sync-template.md` propagates changes.

## Pre-commit Hooks

- Hooks run on changed files: keep pre-commit's default `pass_filenames: true` for every formatter and linter.
- Every formatter and linter must skip file types it does not handle instead of erroring, because hooks receive arbitrary changed-file batches. Use `--no-error-on-unmatched-pattern` for oxfmt, `--ignore-unknown` for prettier, or the equivalent for a new tool.
- `just-fmt` runs `just --fmt --justfile` per matching file and uses the Just version pinned in `.mise/config.toml`. `pre-commit run just-fmt --all-files` formats every justfile.

## Formatting

- oxfmt (`vp fmt`) reads its config from the `fmt` block in `vite.config.ts` and ignores `.oxfmtrc.json`. Keep it a plain object export so it works without `node_modules`; projects with a real Vite+ setup use `defineConfig` from `vite-plus`.
- Tabs everywhere, except YAML (tabs are illegal) and Markdown list indentation (oxfmt emits 4 spaces, matched by `MD007` in `.markdownlint.jsonc`).

## Justfile Options

- Public singular recipe parameters are command-line options with help text: lowercase kebab-case long options such as `--output-file`, or an intentional short option. Booleans are value-less flags such as `--warn` or `--no-clean`.
- Private helper parameters, variadic passthrough parameters, and dependency expressions stay positional.
- `just audit-just-options` inspects every tracked justfile, including imported `.just` modules.

## CI

New jobs in `.github/workflows/merge-group.yml` must be added to `all-checks.needs`.

## Creating a Derived Template

Copy every file, then extend `.pre-commit-config.yaml`, `.gitignore`, the dependabot ecosystems, the merge-group jobs (and `all-checks.needs`), the pull-request auto-fix jobs, and the placeholder job in `push.yml`.

## Validation

Run `just verify` before committing.

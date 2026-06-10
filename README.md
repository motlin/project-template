# Project Template

A language-agnostic base template containing universal configuration patterns for software projects. Language-specific templates (TypeScript, Java, etc.) should use this as a reference and extend its patterns.

## Purpose

This template extracts common, language-agnostic configuration into a single reference. It provides:

- Standard pre-commit hooks for file hygiene
- Universal formatting via oxfmt and markdown linting
- Common gitignore patterns
- Git line ending normalization
- GitHub Actions workflow patterns
- Dependabot configuration structure

## Configuration Files

### `.pre-commit-config.yaml`

Base hooks from `pre-commit/pre-commit-hooks`:

| Hook                      | Purpose                                    |
| ------------------------- | ------------------------------------------ |
| `check-yaml`              | Validate YAML syntax                       |
| `check-json`              | Validate JSON syntax                       |
| `check-toml`              | Validate TOML syntax                       |
| `check-xml`               | Validate XML syntax                        |
| `end-of-file-fixer`       | Ensure files end with newline              |
| `trailing-whitespace`     | Remove trailing whitespace                 |
| `check-added-large-files` | Prevent large files (>1MB)                 |
| `check-case-conflict`     | Detect case-insensitive filename conflicts |
| `check-merge-conflict`    | Detect merge conflict markers              |
| `detect-private-key`      | Prevent committing private keys            |
| `mixed-line-ending`       | Normalize to LF line endings               |

Local hooks for the file types every project has:

| Hook                | Purpose                                            |
| ------------------- | -------------------------------------------------- |
| `oxfmt`             | Format markdown, json, yaml, and toml via `vp fmt` |
| `markdownlint-cli2` | Lint markdown against `.markdownlint.jsonc`        |

**Hook conventions:**

- Hooks run on changed files, not all files: keep pre-commit's default `pass_filenames: true` for every formatter and linter.
- Because hooks receive arbitrary changed-file batches, every formatter and linter must skip file types it does not handle instead of erroring. Use the tool's flag for this: `--no-error-on-unmatched-pattern` for oxfmt, `--ignore-unknown` for prettier, or the equivalent for any new tool.

**Extending:** Add language-specific hooks (eslint for TypeScript, cargo fmt and clippy for Rust) in derived templates.

### `vite.config.ts`

Formatting configuration for oxfmt (`vp fmt`) in the `fmt` block: tabs (`useTabs` with `tabWidth` 4), print width 120, single quotes. A plain object export keeps it working without `node_modules`; vite-plus comes from mise. Note `vp fmt` ignores `.oxfmtrc.json` — the config must live in `vite.config.ts`.

Tabs are the standard across all templates; the exceptions are YAML (tabs are illegal) and markdown list indentation (oxfmt emits 4 spaces, matched by `MD007` in `.markdownlint.jsonc`).

**Extending:** Projects with a real Vite+ setup use `defineConfig` from `vite-plus` and add their build configuration alongside the `fmt` block.

### `.gitignore`

Common patterns:

- Editor/IDE files (.idea, .vscode user files)
- macOS files (.DS_Store)
- Environment files (.envrc, .env)
- LLM context directories (.llm/, .claude/)

**Extending:** Add language-specific patterns (node_modules, target/, dist/).

### `.gitattributes`

- Normalize text files to LF
- Windows batch files use CRLF
- `.idea/` directory not marked as linguist-generated

### `.github/dependabot.yml`

Base configuration for GitHub Actions updates:

- Daily updates at 7:00 AM ET
- 25 open PR limit
- Commit message prefix: "dependabot"

**Extending:** Add language-specific ecosystems (npm, maven).

### `.github/workflows/`

#### `merge-group.yml`

Jobs that run on both `pull_request` and `merge_group`:

- `pre-commit`: Run pre-commit hooks
- `reviewdog-markdownlint`: Lint markdown files
- `reviewdog-yamllint`: Lint YAML files
- `reviewdog-actionlint`: Lint GitHub Actions workflows
- `all-checks`: Gate job using `re-actors/alls-green`

**Extending:** Add language-specific jobs (lint, typecheck, test, build) and add them to `all-checks.needs`.

#### `pull-request.yml`

PR-specific jobs:

- `forbid-merge-commits`: Enforce rebase workflow
- `automerge-dependabot`: Auto-merge Dependabot PRs

**Extending:** Add auto-fix jobs (eslint-fix, biome-fix, prettier-fix).

#### `push.yml`

Main branch jobs:

- Placeholder verify job

**Extending:** Replace with actual build/deploy jobs.

## Extension Mechanism

This template uses a **copy-and-extend** pattern rather than inheritance. Language-specific templates should:

1. **Copy** configuration files from this template
2. **Extend** by adding language-specific content
3. **Document** deviations from the base template

### Why Copy-and-Extend?

- **Simplicity**: No complex inheritance mechanism to maintain
- **Flexibility**: Each template can customize freely
- **Clarity**: All configuration visible in one place
- **Independence**: Templates evolve at their own pace

### Updating from Base Template

When project-template is updated:

1. Review the changes in project-template
2. Manually apply relevant changes to derived templates
3. Test to ensure compatibility

### Alternatives Considered

| Mechanism       | Pros                          | Cons                           |
| --------------- | ----------------------------- | ------------------------------ |
| Git subtree     | Automatic updates             | Complex merge conflicts        |
| Git submodule   | Version pinning               | Extra clone step, confusing UX |
| Symlinks        | Always in sync                | Breaks GitHub template repos   |
| Copy-and-extend | Simple, flexible, independent | Manual update propagation      |

## Derived Templates

Templates that extend this base:

- **typescript-template**: TypeScript/Node.js projects
    - Adds: the full Vite+ toolchain (`vp check`, `vp fmt`, `vp lint`)
    - Adds: npm ecosystem to dependabot
    - Adds: lint, typecheck, test, build jobs

- **rust-template**: Rust projects
    - Adds: cargo fmt (`hard_tabs`) and clippy hooks
    - Adds: cargo ecosystem to dependabot
    - Adds: nextest, llvm-cov jobs

- **java-template**: Java/Maven projects
    - Adds: biome (JSON only), prettier hooks
    - Adds: maven ecosystem to dependabot
    - Adds: maven-test, reviewdog jobs

## Creating a New Language Template

1. Create a new repository
2. Copy all files from project-template
3. Add language-specific configuration:
    - Extend `.pre-commit-config.yaml` with formatters/linters
    - Extend `.gitignore` with build artifacts
    - Add package ecosystem to `.github/dependabot.yml`
    - Add build/test jobs to `.github/workflows/merge-group.yml`
    - Update `all-checks.needs` array
    - Add auto-fix jobs to `.github/workflows/pull-request.yml`
    - Replace placeholder in `.github/workflows/push.yml`
4. Add language-specific files (package.json, pom.xml, etc.)
5. Update README.md with language-specific documentation

## License

Apache 2.0

# Project Template

A language-agnostic base template containing universal configuration patterns for software projects. Language-specific templates (TypeScript, Java, etc.) should use this as a reference and extend its patterns.

## Purpose

This template extracts common, language-agnostic configuration into a single reference. It provides:

- Standard pre-commit hooks for file hygiene
- Universal editor configuration
- Common gitignore patterns
- Git line ending normalization
- GitHub Actions workflow patterns
- Dependabot configuration structure

## Configuration Files

### `.pre-commit-config.yaml`

Base hooks from `pre-commit/pre-commit-hooks`:

| Hook                     | Purpose                                             |
| ------------------------ | --------------------------------------------------- |
| `check-yaml`             | Validate YAML syntax                                |
| `check-json`             | Validate JSON syntax                                |
| `check-toml`             | Validate TOML syntax                                |
| `check-xml`              | Validate XML syntax                                 |
| `end-of-file-fixer`      | Ensure files end with newline                       |
| `trailing-whitespace`    | Remove trailing whitespace                          |
| `check-added-large-files`| Prevent large files (>1MB)                          |
| `check-case-conflict`    | Detect case-insensitive filename conflicts          |
| `check-merge-conflict`   | Detect merge conflict markers                       |
| `detect-private-key`     | Prevent committing private keys                     |
| `mixed-line-ending`      | Normalize to LF line endings                        |

**Extending:** Add language-specific hooks (biome, prettier, eslint) in derived templates.

### `.editorconfig`

Universal formatting settings:

- UTF-8 charset
- LF line endings
- Final newline required
- Trim trailing whitespace
- Language-specific indent settings for YAML, JSON, Makefile, justfile

**Extending:** Override `indent_style` and `indent_size` for language-specific defaults.

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

| Mechanism      | Pros                           | Cons                                |
| -------------- | ------------------------------ | ----------------------------------- |
| Git subtree    | Automatic updates              | Complex merge conflicts             |
| Git submodule  | Version pinning                | Extra clone step, confusing UX      |
| Symlinks       | Always in sync                 | Breaks GitHub template repos        |
| Copy-and-extend| Simple, flexible, independent  | Manual update propagation           |

## Derived Templates

Templates that extend this base:

- **typescript-template**: TypeScript/Node.js projects
  - Adds: biome, prettier, eslint hooks
  - Adds: npm ecosystem to dependabot
  - Adds: lint, typecheck, test, build jobs

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

# Project Template Sync

This is the base template for all projects. It manages foundational files that every project should have.

## Managed Files

### Core Files

- `.gitignore` - Git ignore patterns
- `.pre-commit-config.yaml` - File hygiene, oxfmt, and markdownlint hooks
- `vite.config.ts` - oxfmt formatting settings in the `fmt` block (tabs, width 120)
- `.markdownlint.jsonc` / `.markdownlint-cli2.jsonc` - Markdown lint rules
- `LICENSE` - Apache 2.0 license
- `README.md` - Project documentation structure

### GitHub

- `.github/` - Workflow patterns common to all projects

### Mise (if present)

- `just`, `pre-commit`, `node`, `npm:markdownlint-cli2`, `npm:vite-plus` - language-specific templates manage other tools

## Version Policy

- Always pin specific versions for every tool, never use "latest"

## Sibling Templates

This template provides the foundation for:

- ~/projects/typescript-template (extends with TypeScript/Node tools)
- ~/projects/rust-template (extends with Rust/Cargo tools)
- ~/projects/java-template (extends with Java/Maven tools)

## All Projects

All projects in ~/projects should have the foundational files from this template.

**Skip:**

- ~/projects/open-source/ - owned by others
- Git worktrees (non-main branches)
- Forks (eclipse-collections, znai) - may have their own conventions

## Workflow

### Step 1: Update This Template

Check if this template's `just` version is the latest:

```bash
mise ls-remote just | tail -1
```

Ensure foundational files are up to date:

- LICENSE should be Apache 2.0
- .gitattributes should handle common file types

### .gitattributes (conditional)

`.gitattributes` is NOT copied verbatim. Generate it per repo:

- **Always** include the LF-normalization base:

  ```gitattributes
  # Normalize all text files to LF line endings
  * text=auto eol=lf
  ```

- **Only if** the repo has tracked `*.bat` or `*.cmd` files (`git ls-files '*.bat' '*.cmd'`),
  append:

  ```gitattributes
  # Windows batch files need CRLF
  *.cmd text eol=crlf
  *.bat text eol=crlf
  ```

- **Only if** the repo has tracked `.idea` files (`git ls-files '.idea/**'`), append:

  ```gitattributes
  # Keep .idea files visible in diffs (not marked as generated)
  /.idea/** linguist-generated=false
  ```

- **Preserve** any project-specific rules already present (e.g. `dist/** -diff`,
  `.beads/issues.jsonl merge=beads`, language-specific `eol` overrides).

The base template's own `.gitattributes` contains only the base block because it has no
`.bat`/`.cmd`/`.idea` files.

### Step 2: Pull Improvements from Children

Check typescript-template, rust-template, and java-template for any foundational improvements:

- Better .gitignore patterns
- Improved pre-commit hooks or formatter settings
- New GitHub workflow patterns

If a child template has something better:

1. Verify it's a general improvement (not language-specific)
2. Update this template
3. Push to all other projects

### Step 3: Push to All Projects

For each project, check if foundational files match this template.

Create tasks for mismatches:

```bash
/Users/craig/.claude/plugins/cache/motlin-claude-code-plugins/markdown-tasks/0.18.12/skills/tasks/scripts/task_add.py ~/projects/<project>/.llm/todo.md "Update foundational files from project-template
  Compare and update:
  - .gitattributes
  - LICENSE (should be Apache 2.0)"
```

### Task Templates

**just version update:**

```
Update just <current> → <target>
  Edit .mise/config.toml
  Change: just = "<current>"
  To: just = "<target>"
```

**Pin just version (fix "latest"):**

```
Pin just version (currently "latest")
  Edit .mise/config.toml
  Change: just = "latest"
  To: just = "<target>"
  Note: Never use "latest" - causes inconsistent builds
```

**License update:**

```
Update LICENSE to Apache 2.0
  Copy LICENSE from ~/projects/project-template/LICENSE
  Or from ~/projects/liftwizard/LICENSE
```

## Report Format

After syncing, report:

### This Template Status

- Current just version
- Foundational files status

### Improvements Pulled In

- List any improvements from child templates

### Tasks Distributed

- Number of projects that received tasks
- Breakdown by task type

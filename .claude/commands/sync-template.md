---
description: Sync foundational files from this template to all projects and sibling templates
argument-hint: [project-name|all]
---

# Project Template Sync

This is the base template for all projects. It manages foundational files that every
project should have, and it is the source of truth for the sync system shared by the
sibling templates.

Template path: !`pwd`

## Managed files

- `.gitignore` — Git ignore patterns
- `.prettierignore` — oxfmt exclusions loaded alongside `.gitignore`
- `.pre-commit-config.yaml` — file hygiene, oxfmt, and markdownlint hooks
- `vite.config.ts` — oxfmt formatting settings in the `fmt` block (tabs, width 120)
- `.markdownlint.jsonc` / `.markdownlint-cli2.jsonc` — Markdown lint rules
- `.yamllint.yaml` — YAML lint rules
- `LICENSE` — Apache 2.0 license
- `README.md` — project documentation structure
- `.github/` — workflow patterns common to all projects
- Mise (if present): `just`, `pre-commit`, `node`, `npm:markdownlint-cli2`,
  `npm:vite-plus` — language-specific templates manage other tools

### Shared sync includes

The `.claude/includes/sync-*.md` files are shared by every sibling template's
sync-template command and must be byte-identical in every template repo. During
Step 3, diff each sibling template's copies against this template's and stage a
task on any difference. The sibling commands' section skeletons should also stay
parallel to this file's.

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

## Version policy

@.claude/includes/sync-version-policy.md

## Projects

`$ARGUMENTS` is a project name, `all`, or empty (treated as `all`).

@.claude/includes/sync-project-list.md

This template's scope is every project in `~/projects`, so its `.llm/projects.yaml`
uses `scan` and `skip` instead of an explicit `own` list:

```yaml
scan: ~/projects
skip:
    - ~/projects/open-source # owned by others
    - ~/projects/eclipse-collections # forks keep their own conventions
    - ~/projects/znai
```

Also skip git worktrees (non-main branches).

### Sibling templates

This template provides the foundation for:

- ~/projects/typescript-template (extends with TypeScript/Node tools)
- ~/projects/rust-template (extends with Rust/Cargo tools)
- ~/projects/java-template (extends with Java/Maven tools)

## Stale and conflicting tool configs

@.claude/includes/sync-stale-configs.md

## Default git test

@.claude/includes/sync-git-test.md

## Workflow

### Step 1: Update This Template

Check whether this template's pinned versions are the latest:

```bash
mise ls-remote just | tail -1
```

Ensure foundational files are up to date:

- LICENSE should be Apache 2.0
- .gitattributes should handle common file types

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

For each project, check if foundational files match this template, run the stale-config
scan, and check the default git test. For the sibling templates, also diff the shared
sync includes for byte-identity. Create tasks for mismatches.

## Creating tasks

@.claude/includes/sync-task-dedup.md

Marker for this template: `Source: ~/projects/project-template`

### Task templates

**just version update:**

```
Update just <current> → <target>
  Edit .mise/config.toml
  Change: just = "<current>"
  To: just = "<target>"
  Source: ~/projects/project-template
```

**Pin just version (fix "latest"):**

```
Pin just version (currently "latest")
  Edit .mise/config.toml
  Change: just = "latest"
  To: just = "<target>"
  Note: Never use "latest" - causes inconsistent builds
  Source: ~/projects/project-template
```

**License update:**

```
Update LICENSE to Apache 2.0
  Copy LICENSE from ~/projects/project-template/LICENSE
  Or from ~/projects/liftwizard/LICENSE
  Source: ~/projects/project-template
```

## Report

@.claude/includes/sync-report.md

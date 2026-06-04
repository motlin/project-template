# Project Template Sync

This is the base template for all projects. It manages foundational files that every project should have.

## Managed Files

### Core Files
- `.editorconfig` - Editor settings
- `.gitattributes` - Git attributes
- `.gitignore` - Git ignore patterns
- `LICENSE` - Apache 2.0 license
- `README.md` - Project documentation structure

### GitHub
- `.github/` - Workflow patterns common to all projects

### Mise (if present)
- `just` version only - language-specific templates manage other tools

## Version Policy

- **just**: Always pin specific version, never use "latest"

## Sibling Templates

This template provides the foundation for:
- ~/projects/typescript-template (extends with TypeScript/Node tools)
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
- .editorconfig should have current standards
- .gitattributes should handle common file types

### Step 2: Pull Improvements from Children

Check typescript-template and java-template for any foundational improvements:
- Better .gitignore patterns
- Improved .editorconfig settings
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
  - .editorconfig
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

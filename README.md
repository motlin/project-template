# Project Template

A language-agnostic base template for setting up a new project, and for keeping many projects in sync so they stay similar over time.

## Who It Is For

Use this template if you maintain several repositories and want them to share the same file hygiene, formatting, linting, CI, and dependency-update setup without maintaining each one by hand.

## What It Covers

- Pre-commit hooks for file hygiene, formatting, and linting
- Formatting and Markdown linting shared by every project
- Common `.gitignore` and `.gitattributes` patterns
- A `justfile` with shared recipes
- GitHub Actions workflows for pull requests, merge queues, and pushes to main
- Dependabot configuration for GitHub Actions
- Tool versions managed through mise

## How It Relates to Other Templates

This is the base. Language-specific templates copy its files and extend them with their own toolchains:

- **typescript-template**: TypeScript and Node.js projects
- **rust-template**: Rust projects
- **java-template**: Java and Maven projects
- **playdate-template**: Playdate games in Lua

Templates use a copy-and-extend pattern rather than inheritance (git subtree, submodules, or symlinks). Each template stays simple and independent, at the cost of propagating updates manually. A sync command in this repository copies changes from the base out to derived templates and projects.

## License

Apache 2.0

set dotenv-filename := ".envrc"

import ".just/console.just"
import ".just/git.just"
import ".just/git-test.just"

# `just --list --unsorted`
default:
    @just --list --unsorted

# `mise install`
mise:
    mise install --quiet
    mise current

# clean (git only - language-specific templates should extend)
@clean: _clean-git

# Run pre-commit hooks
verify:
    pre-commit run --all-files

# Audit public singular recipe parameters for documented options
audit-just-options:
    python3 scripts/audit-just-options.py

# Override this with a command called `woof` which notifies you in whatever ways you prefer.
# My `woof` command uses `echo`, `say`, and sends a Pushover notification.
echo_command := env('ECHO_COMMAND', "echo")

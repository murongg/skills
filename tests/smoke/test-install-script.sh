#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
INSTALL_SCRIPT="$REPO_ROOT/scripts/install.sh"

interactive_output=$(printf '5\n' | bash "$INSTALL_SCRIPT" 2>&1 || true)

if ! grep -q "Select installation target" <<< "$interactive_output"; then
    echo "[FAIL] install.sh did not show an interactive selection prompt"
    exit 1
fi

if ! grep -q "1) codex" <<< "$interactive_output"; then
    echo "[FAIL] install.sh did not show platform choices"
    exit 1
fi

non_interactive_output=$(bash "$INSTALL_SCRIPT" --help 2>&1)

if grep -q "Select installation target" <<< "$non_interactive_output"; then
    echo "[FAIL] install.sh entered interactive mode for --help"
    exit 1
fi

echo "[PASS] install.sh supports interactive and non-interactive modes"

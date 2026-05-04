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

TEST_HOME="$(mktemp -d)"
trap 'rm -rf "$TEST_HOME"' EXIT

HOME="$TEST_HOME" bash "$INSTALL_SCRIPT" --platform all >/dev/null 2>&1

if [ ! -d "$TEST_HOME/.agents/skills/my-skills" ]; then
    echo "[FAIL] install.sh did not create the central my-skills directory under ~/.agents/skills"
    exit 1
fi

if [ -L "$TEST_HOME/.agents/skills/my-skills" ]; then
    echo "[FAIL] ~/.agents/skills/my-skills should be a real directory, not a symlink"
    exit 1
fi

if [ ! -f "$TEST_HOME/.agents/skills/my-skills/ui-ux-pro-max/SKILL.md" ]; then
    echo "[FAIL] central my-skills install does not include vendored ui-ux-pro-max inside the generated skills tree"
    exit 1
fi

if [ ! -f "$TEST_HOME/.agents/skills/my-skills/impeccable/SKILL.md" ]; then
    echo "[FAIL] central my-skills install does not include vendored impeccable frontend-design inside the generated skills tree"
    exit 1
fi

if [ -L "$TEST_HOME/.agents/skills/my-skills/ui-ux-pro-max" ]; then
    echo "[FAIL] vendored ui-ux-pro-max inside ~/.agents/skills/my-skills should be real files, not a symlink"
    exit 1
fi

if [ ! -d "$TEST_HOME/.agents/skills/my-skills/ui-ux-pro-max/data" ] || [ -L "$TEST_HOME/.agents/skills/my-skills/ui-ux-pro-max/data" ]; then
    echo "[FAIL] ui-ux-pro-max/data should be a real directory in the installed skills tree"
    exit 1
fi

if [ ! -d "$TEST_HOME/.agents/skills/my-skills/ui-ux-pro-max/scripts" ] || [ -L "$TEST_HOME/.agents/skills/my-skills/ui-ux-pro-max/scripts" ]; then
    echo "[FAIL] ui-ux-pro-max/scripts should be a real directory in the installed skills tree"
    exit 1
fi

if [ ! -f "$TEST_HOME/.agents/skills/my-skills/vercel-react-best-practices/SKILL.md" ]; then
    echo "[FAIL] central my-skills install does not include vendored vercel-react-best-practices inside the generated skills tree"
    exit 1
fi

if [ -L "$TEST_HOME/.agents/skills/my-skills/vercel-react-best-practices" ]; then
    echo "[FAIL] vendored vercel-react-best-practices inside ~/.agents/skills/my-skills should be real files, not a symlink"
    exit 1
fi

if [ ! -f "$TEST_HOME/.agents/skills/my-skills/composition-patterns/SKILL.md" ]; then
    echo "[FAIL] central my-skills install does not include vendored composition-patterns inside the generated skills tree"
    exit 1
fi

if [ ! -L "$TEST_HOME/.claude/skills/my-skills" ]; then
    echo "[FAIL] install.sh did not link Claude to the central my-skills directory"
    exit 1
fi

if [ ! -L "$TEST_HOME/.config/opencode/skills/my-skills" ]; then
    echo "[FAIL] install.sh did not link OpenCode to the central my-skills directory"
    exit 1
fi

if [ "$(readlink "$TEST_HOME/.claude/skills/my-skills")" != "$TEST_HOME/.agents/skills/my-skills" ]; then
    echo "[FAIL] Claude my-skills link does not point to ~/.agents/skills/my-skills"
    exit 1
fi

if [ "$(readlink "$TEST_HOME/.config/opencode/skills/my-skills")" != "$TEST_HOME/.agents/skills/my-skills" ]; then
    echo "[FAIL] OpenCode my-skills link does not point to ~/.agents/skills/my-skills"
    exit 1
fi

REMOTE_TEST_HOME="$(mktemp -d)"
cp "$INSTALL_SCRIPT" "$REMOTE_TEST_HOME/install.sh"

BOOTSTRAP_SOURCE_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_HOME" "$REMOTE_TEST_HOME" "$BOOTSTRAP_SOURCE_ROOT"' EXIT
BOOTSTRAP_SOURCE_REPO="$BOOTSTRAP_SOURCE_ROOT/skills"
rsync -a --exclude .git --exclude .generated "$REPO_ROOT/" "$BOOTSTRAP_SOURCE_REPO/"
git -C "$BOOTSTRAP_SOURCE_REPO" init >/dev/null 2>&1
git -C "$BOOTSTRAP_SOURCE_REPO" add . >/dev/null 2>&1
git -C "$BOOTSTRAP_SOURCE_REPO" \
    -c user.name="Smoke Test" \
    -c user.email="smoke@example.com" \
    commit -m "Create bootstrap fixture" >/dev/null 2>&1

if MY_SKILLS_REPO_URL="$BOOTSTRAP_SOURCE_REPO" HOME="$TEST_HOME" bash "$REMOTE_TEST_HOME/install.sh" --platform codex >/tmp/my-skills-remote-install.log 2>&1; then
    :
else
    echo "[FAIL] install.sh should bootstrap from a temporary clone when executed outside the repo"
    cat /tmp/my-skills-remote-install.log
    exit 1
fi

if [ ! -d "$TEST_HOME/.agents/skills/my-skills" ]; then
    echo "[FAIL] repo-bootstrap install did not create the central skills directory"
    exit 1
fi

echo "[PASS] install.sh supports interactive mode and installs one central clean skills tree under ~/.agents"

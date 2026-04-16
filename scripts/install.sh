#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SKILLS_SOURCE="$REPO_ROOT/skills"
SKILL_NAME="my-skills"

usage() {
    cat <<EOF
Usage: scripts/install.sh [--platform codex|opencode|claude|all]

Creates local symlinks so supported tools can discover the skills in this repo.

Options:
  --platform <name>   Install for one platform or all platforms (default: all)
  --help              Show this help text

Supported platforms:
  codex      -> ~/.agents/skills/my-skills
  opencode   -> ~/.config/opencode/skills/my-skills
  claude     -> ~/.claude/skills/my-skills
  all        -> install all of the above
EOF
}

TARGET_PLATFORM=""

prompt_for_platform() {
    cat <<EOF
Select installation target:
  1) codex
  2) opencode
  3) claude
  4) all
EOF

    printf 'Enter choice [1-4]: '
    read -r choice

    case "$choice" in
        1) TARGET_PLATFORM="codex" ;;
        2) TARGET_PLATFORM="opencode" ;;
        3) TARGET_PLATFORM="claude" ;;
        4) TARGET_PLATFORM="all" ;;
        *)
            echo "[FAIL] Invalid selection: $choice" >&2
            exit 1
            ;;
    esac
}

confirm_install() {
    cat <<EOF

About to install for: $TARGET_PLATFORM
Skills source: $SKILLS_SOURCE
EOF

    printf 'Proceed? [y/N]: '
    read -r confirm

    case "$confirm" in
        y|Y|yes|YES)
            ;;
        *)
            echo "Install cancelled."
            exit 1
            ;;
    esac
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --platform)
            if [ "$#" -lt 2 ]; then
                echo "[FAIL] --platform requires a value" >&2
                usage
                exit 1
            fi
            TARGET_PLATFORM="$2"
            shift 2
            ;;
        --help|-h)
            usage
            exit 0
            ;;
        *)
            echo "[FAIL] Unknown argument: $1" >&2
            usage
            exit 1
            ;;
        esac
done

if [ -z "$TARGET_PLATFORM" ]; then
    prompt_for_platform
    confirm_install
fi

ensure_link() {
    local target_dir="$1"
    local target_path="$2"

    mkdir -p "$target_dir"

    if [ -L "$target_path" ]; then
        local current_target
        current_target="$(readlink "$target_path")"
        if [ "$current_target" = "$SKILLS_SOURCE" ]; then
            echo "[OK] Already linked: $target_path"
            return 0
        fi

        echo "[FAIL] $target_path already points to $current_target" >&2
        echo "       Remove it manually if you want to replace it." >&2
        exit 1
    fi

    if [ -e "$target_path" ]; then
        echo "[FAIL] $target_path already exists and is not a symlink" >&2
        echo "       Move or remove it manually, then rerun this script." >&2
        exit 1
    fi

    ln -s "$SKILLS_SOURCE" "$target_path"
    echo "[OK] Linked $target_path -> $SKILLS_SOURCE"
}

install_codex() {
    ensure_link "$HOME/.agents/skills" "$HOME/.agents/skills/$SKILL_NAME"
}

install_opencode() {
    ensure_link "$HOME/.config/opencode/skills" "$HOME/.config/opencode/skills/$SKILL_NAME"
}

install_claude() {
    ensure_link "$HOME/.claude/skills" "$HOME/.claude/skills/$SKILL_NAME"
}

case "$TARGET_PLATFORM" in
    codex)
        install_codex
        ;;
    opencode)
        install_opencode
        ;;
    claude)
        install_claude
        ;;
    all)
        install_codex
        install_opencode
        install_claude
        ;;
    *)
        echo "[FAIL] Unsupported platform: $TARGET_PLATFORM" >&2
        usage
        exit 1
        ;;
esac

cat <<EOF

Install complete.

Next steps:
  1. Restart the target tool.
  2. Ask it to load or use the \
     $SKILL_NAME/use-my-skills skill.
  3. Verify that it can see files under:
     $SKILLS_SOURCE
EOF

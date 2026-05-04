#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_URL="${MY_SKILLS_REPO_URL:-https://github.com/murongg/skills.git}"

bootstrap_repo_if_needed() {
    if [ -d "$REPO_ROOT/skills" ] && [ -d "$REPO_ROOT/vendor/vercel-skills" ] && [ -d "$REPO_ROOT/vendor/ui-ux-pro-max" ] && [ -d "$REPO_ROOT/vendor/impeccable" ]; then
        return 0
    fi

    local bootstrap_root bootstrap_repo
    bootstrap_root="$(mktemp -d)"
    bootstrap_repo="$bootstrap_root/skills"

    git clone "$REPO_URL" "$bootstrap_repo" >/dev/null 2>&1
    git -C "$bootstrap_repo" submodule update --init --recursive >/dev/null 2>&1

    REPO_ROOT="$bootstrap_repo"
    SCRIPT_DIR="$bootstrap_repo/scripts"
}

bootstrap_repo_if_needed

SKILLS_SOURCE="$REPO_ROOT/skills"
SKILL_NAME="my-skills"
GENERATED_ROOT="$REPO_ROOT/.generated"
GENERATED_SKILLS_DIR="$GENERATED_ROOT/skills"
VENDORED_SKILLS=(
    "vendor/vercel-skills/skills/react-best-practices:vercel-react-best-practices"
    "vendor/vercel-skills/skills/composition-patterns:composition-patterns"
    "vendor/vercel-skills/skills/react-native-skills:react-native-skills"
    "vendor/vercel-skills/skills/react-view-transitions:react-view-transitions"
    "vendor/vercel-skills/skills/web-design-guidelines:web-design-guidelines"
    "vendor/vercel-skills/skills/vercel-cli-with-tokens:vercel-cli-with-tokens"
    "vendor/vercel-skills/skills/deploy-to-vercel:deploy-to-vercel"
    "vendor/ui-ux-pro-max/.claude/skills/ui-ux-pro-max:ui-ux-pro-max"
    "vendor/impeccable/.agents/skills/impeccable:impeccable"
)

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
Core skills source: $SKILLS_SOURCE
Generated install tree: $GENERATED_SKILLS_DIR
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

prepare_generated_tree() {
    local source_path entry source_rel_path alias_name

    rm -rf "$GENERATED_SKILLS_DIR"
    mkdir -p "$GENERATED_SKILLS_DIR"

    for source_path in "$SKILLS_SOURCE"/*; do
        [ -d "$source_path" ] || continue
        mkdir -p "$GENERATED_SKILLS_DIR/${source_path##*/}"
        cp -R "$source_path/." "$GENERATED_SKILLS_DIR/${source_path##*/}/"
    done

    for entry in "${VENDORED_SKILLS[@]}"; do
        source_rel_path="${entry%%:*}"
        alias_name="${entry##*:}"
        source_path="$REPO_ROOT/$source_rel_path"

        if [ ! -d "$source_path" ]; then
            echo "[FAIL] Missing vendored skill source: $source_path" >&2
            exit 1
        fi

        mkdir -p "$GENERATED_SKILLS_DIR/$alias_name"
        cp -R -L "$source_path/." "$GENERATED_SKILLS_DIR/$alias_name/"
    done
}

prepare_generated_tree

ensure_symlink() {
    local target_dir="$1"
    local target_path="$2"
    local source_path="$3"

    mkdir -p "$target_dir"

    if [ -L "$target_path" ]; then
        local current_target
        current_target="$(readlink "$target_path")"
        if [ "$current_target" = "$source_path" ]; then
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

    ln -s "$source_path" "$target_path"
    echo "[OK] Linked $target_path -> $source_path"
}

install_central_tree() {
    local central_dir="$HOME/.agents/skills/$SKILL_NAME"

    mkdir -p "$HOME/.agents/skills"

    if [ -L "$central_dir" ]; then
        echo "[FAIL] $central_dir is a symlink, but ~/.agents must contain a real directory" >&2
        echo "       Remove it manually, then rerun this script." >&2
        exit 1
    fi

    if [ -e "$central_dir" ] && [ ! -d "$central_dir" ]; then
        echo "[FAIL] $central_dir exists and is not a directory" >&2
        echo "       Remove it manually, then rerun this script." >&2
        exit 1
    fi

    rm -rf "$central_dir"
    mkdir -p "$central_dir"
    cp -R "$GENERATED_SKILLS_DIR/." "$central_dir/"
    echo "[OK] Installed real skills directory at $central_dir"
}

install_codex() {
    install_central_tree
}

install_opencode() {
    ensure_symlink "$HOME/.config/opencode/skills" "$HOME/.config/opencode/skills/$SKILL_NAME" "$HOME/.agents/skills/$SKILL_NAME"
}

install_claude() {
    ensure_symlink "$HOME/.claude/skills" "$HOME/.claude/skills/$SKILL_NAME" "$HOME/.agents/skills/$SKILL_NAME"
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
     $GENERATED_SKILLS_DIR
EOF

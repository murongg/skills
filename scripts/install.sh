#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
REPO_URL="${MY_SKILLS_REPO_URL:-https://github.com/murongg/skills.git}"

bootstrap_repo_if_needed() {
    if [ -d "$REPO_ROOT/skills" ] && [ -d "$REPO_ROOT/vendor/vercel-skills" ] && [ -d "$REPO_ROOT/vendor/ui-ux-pro-max" ] && [ -d "$REPO_ROOT/vendor/impeccable" ] && [ -d "$REPO_ROOT/vendor/taste-skill" ] && [ -d "$REPO_ROOT/vendor/ponytail" ]; then
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
    "vendor/ponytail/skills/ponytail:ponytail"
    "vendor/ponytail/skills/ponytail-review:ponytail-review"
    "vendor/ponytail/skills/ponytail-audit:ponytail-audit"
    "vendor/taste-skill/skills/brandkit:brandkit"
    "vendor/taste-skill/skills/brutalist-skill:industrial-brutalist-ui"
    "vendor/taste-skill/skills/gpt-tasteskill:gpt-taste"
    "vendor/taste-skill/skills/image-to-code-skill:image-to-code"
    "vendor/taste-skill/skills/imagegen-frontend-mobile:imagegen-frontend-mobile"
    "vendor/taste-skill/skills/imagegen-frontend-web:imagegen-frontend-web"
    "vendor/taste-skill/skills/minimalist-skill:minimalist-ui"
    "vendor/taste-skill/skills/output-skill:full-output-enforcement"
    "vendor/taste-skill/skills/redesign-skill:redesign-existing-projects"
    "vendor/taste-skill/skills/soft-skill:high-end-visual-design"
    "vendor/taste-skill/skills/stitch-skill:stitch-design-taste"
    "vendor/taste-skill/skills/taste-skill-v1:design-taste-frontend-v1"
    "vendor/taste-skill/skills/taste-skill:design-taste-frontend"
)

usage() {
    cat <<EOF
Usage: scripts/install.sh [--platform codex|opencode|claude|all] [--with-ponytail-plugin]

Installs the central skills tree and links supported tools to it.

Options:
  --platform <name>   Install for one platform or all platforms (default: all)
  --with-ponytail-plugin
                      Also install the official Ponytail plugin for the selected tools
                      Requires Node.js and each selected tool's plugin-capable CLI
  --help              Show this help text

Supported platforms:
  codex      -> ~/.agents/skills/my-skills
  opencode   -> ~/.config/opencode/skills/my-skills
  claude     -> ~/.claude/skills/my-skills
  all        -> install all of the above, plus ~/.gemini/GEMINI.md

Base files overwritten:
  codex      -> ~/.codex/AGENTS.md
  claude     -> ~/.claude/CLAUDE.md
  all        -> ~/.codex/AGENTS.md, ~/.claude/CLAUDE.md, ~/.gemini/GEMINI.md
EOF
}

TARGET_PLATFORM=""
INSTALL_PONYTAIL_PLUGIN=false
PONYTAIL_HOSTS=()

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
Install native Ponytail plugin: $INSTALL_PONYTAIL_PLUGIN
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
        --with-ponytail-plugin)
            INSTALL_PONYTAIL_PLUGIN=true
            shift
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

case "$TARGET_PLATFORM" in
    codex|opencode|claude) PONYTAIL_HOSTS=("$TARGET_PLATFORM") ;;
    all) PONYTAIL_HOSTS=(codex claude opencode gemini) ;;
    *) echo "[FAIL] Unsupported platform: $TARGET_PLATFORM" >&2; exit 1 ;;
esac

# Check optional plugin requirements before overwriting any installed skills.
if [ "$INSTALL_PONYTAIL_PLUGIN" = true ]; then
    if ! command -v node >/dev/null 2>&1; then
        echo "[FAIL] Node.js is required for Ponytail's lifecycle hooks" >&2
        exit 1
    fi
    for plugin_host in "${PONYTAIL_HOSTS[@]}"; do
        if ! command -v "$plugin_host" >/dev/null 2>&1; then
            echo "[FAIL] Missing $plugin_host CLI; install it or select a different --platform" >&2
            exit 1
        fi
        case "$plugin_host" in
            codex|opencode) plugin_command=(plugin add) ;;
            claude) plugin_command=(plugin install) ;;
            gemini) plugin_command=(extensions install) ;;
        esac
        if ! "$plugin_host" "${plugin_command[@]}" --help >/dev/null 2>&1; then
            echo "[FAIL] $plugin_host lacks the required plugin command; upgrade its CLI" >&2
            exit 1
        fi
    done
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
        if [[ "$source_rel_path" == vendor/ponytail/* ]]; then
            cp "$REPO_ROOT/vendor/ponytail/LICENSE" "$GENERATED_SKILLS_DIR/$alias_name/LICENSE"
        fi
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

install_base_file() {
    local source_file="$1"
    local target_file="$2"
    local target_dir

    if [ ! -f "$source_file" ]; then
        echo "[FAIL] Missing base file source: $source_file" >&2
        exit 1
    fi

    if [ -d "$target_file" ]; then
        echo "[FAIL] $target_file already exists and is a directory" >&2
        echo "       Move or remove it manually, then rerun this script." >&2
        exit 1
    fi

    target_dir="$(dirname "$target_file")"
    mkdir -p "$target_dir"
    cp "$source_file" "$target_file"
    echo "[OK] Installed base file at $target_file"
}

install_codex() {
    install_base_file "$REPO_ROOT/AGENTS.md" "$HOME/.codex/AGENTS.md"
}

install_opencode() {
    ensure_symlink "$HOME/.config/opencode/skills" "$HOME/.config/opencode/skills/$SKILL_NAME" "$HOME/.agents/skills/$SKILL_NAME"
}

install_claude() {
    ensure_symlink "$HOME/.claude/skills" "$HOME/.claude/skills/$SKILL_NAME" "$HOME/.agents/skills/$SKILL_NAME"
    install_base_file "$REPO_ROOT/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
}

install_gemini_base() {
    install_base_file "$REPO_ROOT/GEMINI.md" "$HOME/.gemini/GEMINI.md"
}

ensure_ponytail_marketplace() {
    local plugin_host="$1"
    local registered
    registered="$("$plugin_host" plugin marketplace list --json | node -e '
        const fs = require("fs");
        const data = JSON.parse(fs.readFileSync(0, "utf8"));
        const entries = Array.isArray(data) ? data : data.marketplaces;
        if (!Array.isArray(entries)) throw new Error("Invalid marketplace list");
        process.stdout.write(entries.some(entry => entry.name === "ponytail") ? "yes" : "no");
    ')"
    if [ "$registered" = no ]; then
        "$plugin_host" plugin marketplace add DietrichGebert/ponytail
    fi
}

install_ponytail_plugins() {
    local plugin_host installed
    for plugin_host in "${PONYTAIL_HOSTS[@]}"; do
        case "$plugin_host" in
            codex)
                ensure_ponytail_marketplace codex
                codex plugin add ponytail@ponytail
                echo '[NEXT] In Codex, open /hooks to review and trust Ponytail hooks, then start a new chat.'
                ;;
            claude)
                ensure_ponytail_marketplace claude
                claude plugin install ponytail@ponytail --scope user
                echo '[NEXT] Restart Claude Code; Ponytail Band and its local board are included in the plugin.'
                ;;
            opencode)
                opencode plugin add @dietrichgebert/ponytail
                ;;
            gemini)
                installed="$(gemini extensions list --output-format json | node -e '
                    const fs = require("fs");
                    const entries = JSON.parse(fs.readFileSync(0, "utf8"));
                    if (!Array.isArray(entries)) throw new Error("Invalid extension list");
                    process.stdout.write(entries.some(entry => entry.name === "ponytail") ? "yes" : "no");
                ')"
                if [ "$installed" = no ]; then
                    gemini extensions install https://github.com/DietrichGebert/ponytail --consent
                fi
                ;;
        esac
        echo "[OK] Ponytail plugin installed for $plugin_host"
    done
}

# Claude and OpenCode also need a fresh central tree when installed on their own.
install_central_tree

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
        install_gemini_base
        ;;
    *)
        echo "[FAIL] Unsupported platform: $TARGET_PLATFORM" >&2
        usage
        exit 1
        ;;
esac

if [ "$INSTALL_PONYTAIL_PLUGIN" = true ]; then
    install_ponytail_plugins
fi

cat <<EOF

Install complete.

Next steps:
  1. Restart the target tool.
  2. Ask it to load or use the \
     $SKILL_NAME/use-my-skills skill.
  3. Verify that it can see files under:
     $GENERATED_SKILLS_DIR
EOF

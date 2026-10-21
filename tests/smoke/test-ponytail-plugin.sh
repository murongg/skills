#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TEST_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEST_ROOT"' EXIT
mkdir -p "$TEST_ROOT/bin"

# Stub only host CLIs: no plugin downloads or changes to real user settings.
cat > "$TEST_ROOT/bin/host" <<'STUB'
#!/usr/bin/env bash
set -euo pipefail
host="${0##*/}"
printf '%s %s\n' "$host" "$*" >> "$PLUGIN_TEST_LOG"
if [[ "$*" == *--help* ]]; then
    [ "${PLUGIN_TEST_UNSUPPORTED:-}" != "$host" ]
    exit
fi
if [ "${PLUGIN_TEST_FAIL:-}" = "$host" ]; then
    echo "synthetic plugin install failure" >&2
    exit 42
fi
case "$*" in
    'plugin marketplace list --json')
        if [ "$host" = codex ]; then
            printf '{"marketplaces":['
        else
            printf '['
        fi
        if [ -f "$HOME/$host-marketplace" ]; then
            printf '{"name":"ponytail"}'
        fi
        if [ "$host" = codex ]; then printf ']}\n'; else printf ']\n'; fi
        ;;
    'plugin marketplace add DietrichGebert/ponytail')
        touch "$HOME/$host-marketplace"
        ;;
    'plugin add ponytail@ponytail'|'plugin install ponytail@ponytail --scope user'|'plugin add @dietrichgebert/ponytail')
        touch "$HOME/$host-installed"
        ;;
    'extensions list --output-format json')
        if [ -f "$HOME/gemini-installed" ]; then
            printf '[{"name":"ponytail"}]\n' >&2
        else
            printf '[]\n' >&2
        fi
        ;;
    'extensions install https://github.com/DietrichGebert/ponytail --consent')
        touch "$HOME/gemini-installed"
        ;;
    *) echo "Unexpected host command: $host $*" >&2; exit 1 ;;
esac
STUB
chmod +x "$TEST_ROOT/bin/host"
for host in codex claude opencode gemini; do
    ln -s host "$TEST_ROOT/bin/$host"
done
export PATH="$TEST_ROOT/bin:$PATH"
export PLUGIN_TEST_LOG="$TEST_ROOT/commands.log"

for platform in codex claude opencode all; do
    platform_home="$TEST_ROOT/$platform"
    mkdir -p "$platform_home"
    : > "$PLUGIN_TEST_LOG"
    if ! HOME="$platform_home" bash "$REPO_ROOT/scripts/install.sh" --platform "$platform" --with-ponytail-plugin > "$TEST_ROOT/output" 2>&1; then
        cat "$TEST_ROOT/output"
        exit 1
    fi
    expected_hosts="$platform"
    if [ "$platform" = all ]; then expected_hosts="codex claude opencode gemini"; fi
    for host in codex claude opencode gemini; do
        case " $expected_hosts " in
            *" $host "*) test -f "$platform_home/$host-installed" ;;
            *) test ! -f "$platform_home/$host-installed" ;;
        esac
    done
    test -f "$platform_home/.agents/skills/my-skills/ponytail/SKILL.md"
done

# Existing marketplaces and Gemini extensions must survive a repeated install.
: > "$PLUGIN_TEST_LOG"
HOME="$TEST_ROOT/all" bash "$REPO_ROOT/scripts/install.sh" --platform all --with-ponytail-plugin > "$TEST_ROOT/output" 2>&1
if grep -Eq 'plugin marketplace add |extensions install https://' "$PLUGIN_TEST_LOG"; then
    echo "[FAIL] repeat install tried to register an existing marketplace or extension"
    exit 1
fi

: > "$PLUGIN_TEST_LOG"
HOME="$TEST_ROOT/all" bash "$REPO_ROOT/scripts/install.sh" --platform codex > "$TEST_ROOT/output" 2>&1
if [ -s "$PLUGIN_TEST_LOG" ]; then
    echo "[FAIL] default install invoked a native plugin CLI"
    exit 1
fi

mkdir -p "$TEST_ROOT/unsupported"
if HOME="$TEST_ROOT/unsupported" PLUGIN_TEST_UNSUPPORTED=codex bash "$REPO_ROOT/scripts/install.sh" --platform codex --with-ponytail-plugin > "$TEST_ROOT/output" 2>&1; then
    echo "[FAIL] unsupported plugin CLI was accepted"
    exit 1
fi
test ! -e "$TEST_ROOT/unsupported/.agents/skills/my-skills"
grep -q 'codex' "$TEST_ROOT/output"

mkdir -p "$TEST_ROOT/failure"
if HOME="$TEST_ROOT/failure" PLUGIN_TEST_FAIL=claude bash "$REPO_ROOT/scripts/install.sh" --platform claude --with-ponytail-plugin > "$TEST_ROOT/output" 2>&1; then
    echo "[FAIL] plugin CLI failure was reported as success"
    exit 1
fi
grep -q 'synthetic plugin install failure' "$TEST_ROOT/output"
if grep -q 'Install complete' "$TEST_ROOT/output"; then
    echo "[FAIL] failed plugin install printed a completion message"
    exit 1
fi

echo "[PASS] native Ponytail plugins follow platform selection, support repeat installs, and propagate failures"

#!/usr/bin/env bash
set -e -o pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/dotfiles-tests.XXXXXXXX")"
trap 'rm -rf "$test_dir"' EXIT

mkdir -p "$test_dir/bin"
cat > "$test_dir/bin/mock" <<'MOCK'
#!/usr/bin/env bash
set -e -o pipefail
command="${0##*/}"
case "$command" in
    sudo)
        if [[ "$1" == tar ]]; then
            cat >/dev/null
            touch "$HOME/neovim-installed"
        elif [[ "${MOCK_FAIL:-}" == apt ]]; then
            echo "mock apt failure" >&2
            exit 1
        fi
        ;;
    npm)
        [[ "${MOCK_FAIL:-}" != npm ]]
        ;;
    go)
        [[ "$*" != *"${MOCK_FAIL:-no-failure}"* ]]
        ;;
    curl)
        [[ "${MOCK_FAIL:-}" != curl ]]
        ;;
    git)
        [[ "${MOCK_FAIL:-}" != clone ]] || exit 1
        [[ "$1" != clone ]] || mkdir -p "${@: -1}"
        ;;
    nvim)
        if [[ -n "${MOCK_REAL_NVIM:-}" ]]; then
            exec "$MOCK_REAL_NVIM" -u NONE -i NONE -n "$@"
        fi
        if [[ "$*" == *'has("nvim-0.11")'* ]]; then
            case "${MOCK_NVIM_VERSION:-0.11.0}" in
                0.9.*|0.10.*) [[ -f "$HOME/neovim-installed" ]] ;;
                *) exit 0 ;;
            esac
        else
            case "${MOCK_NVIM_VERSION:-0.11.0}" in
                0.9.*|0.10.*) [[ -f "$HOME/neovim-installed" ]] || exit 1 ;;
            esac
            touch "$HOME/parsers-attempted"
            [[ "${MOCK_FAIL:-}" != parsers ]]
        fi
        ;;
    tree-sitter) exit 0 ;;
esac
MOCK
chmod +x "$test_dir/bin/mock"
for command in sudo npm go curl git nvim tree-sitter; do
    ln -s mock "$test_dir/bin/$command"
done

new_home() {
    export HOME="$test_dir/$1"
    export XDG_DATA_HOME="$HOME/data"
    mkdir -p "$HOME/.fzf"
}

run_installer() {
    CODESPACES=true PATH="$test_dir/bin:$PATH" \
        bash "$repo/install.sh" >"$HOME/install.log" 2>&1
}

fail() {
    echo "FAIL: $*" >&2
    cat "$HOME/install.log" >&2
    exit 1
}

for version in 0.9.5 0.10.4 0.11.0 0.12.0 1.0.0; do
    new_home "version-$version"
    export MOCK_NVIM_VERSION="$version"
    run_installer || fail "install with Neovim $version"
    case "$version" in
        0.9.*|0.10.*)
            [[ -f "$HOME/neovim-installed" ]] || fail "$version was not upgraded"
            ;;
        *)
            [[ ! -e "$HOME/neovim-installed" ]] || fail "$version was needlessly replaced"
            ;;
    esac
    [[ -f "$HOME/parsers-attempted" ]] || fail "plugin setup did not run"
    echo "PASS: Neovim $version compatibility and plugin ordering"
done
unset MOCK_NVIM_VERSION

for failure in apt npm gopls goimports curl clone parsers; do
    new_home "failure-$failure"
    export MOCK_FAIL="$failure"
    # Force the download path when checking pipeline failure propagation.
    export MOCK_NVIM_VERSION=0.9.5
    if run_installer; then
        fail "$failure failure incorrectly reported success"
    fi
    if [[ "$failure" == curl && -e "$HOME/parsers-attempted" ]]; then
        fail "plugins ran after Neovim installation failed"
    fi
    echo "PASS: $failure failure propagates"
done
unset MOCK_FAIL MOCK_NVIM_VERSION

new_home existing-configs
for config in nvim tmux zsh; do
    mkdir -p "$HOME/.config/$config"
    printf '%s\n' "$config" > "$HOME/.config/$config/keep"
done
printf 'existing zshenv\n' > "$HOME/.zshenv"
skills=("$repo"/copilot/.copilot/skills/*)
skill="${skills[0]##*/}"
mkdir -p "$HOME/.copilot/skills/$skill"
printf 'existing skill\n' > "$HOME/.copilot/skills/$skill/keep"
run_installer || fail "install over real configs"
backups=("$HOME"/.config-backup-*)
[[ ${#backups[@]} -eq 1 ]] || fail "expected one backup directory"
backup="${backups[0]}"
for config in nvim tmux zsh; do
    [[ "$(cat "$backup/.config/$config/keep")" == "$config" ]] || fail "$config backup lost"
    [[ "$(readlink "$HOME/.config/$config")" == "$repo/$config/.config/$config" ]] ||
        fail "$config symlink incorrect"
done
[[ "$(cat "$backup/.zshenv")" == 'existing zshenv' ]] || fail "zshenv backup lost"
[[ "$(readlink "$HOME/.zshenv")" == "$repo/zsh/.zshenv" ]] || fail "zshenv symlink incorrect"
[[ "$(cat "$backup/.copilot/skills/$skill/keep")" == 'existing skill' ]] || fail "skill backup lost"
run_installer || fail "repeated install"
backups=("$HOME"/.config-backup-*)
[[ ${#backups[@]} -eq 1 ]] || fail "repeated install created extra backups"
[[ "$(cat "$backup/.config/nvim/keep")" == nvim ]] || fail "repeated install damaged backup"
echo "PASS: config backups and repeated setup"

new_home dangling-config
mkdir -p "$HOME/.config"
ln -s "$HOME/missing-config" "$HOME/.config/nvim"
run_installer || fail "install over dangling symlink"
[[ "$(readlink "$HOME/.config/nvim")" == "$repo/nvim/.config/nvim" ]] ||
    fail "dangling symlink not replaced"
echo "PASS: dangling config symlink replaced"

new_home not-codespaces
if CODESPACES=false PATH="$test_dir/bin:$PATH" bash "$repo/install.sh" >"$HOME/install.log" 2>&1; then
    fail "installer ran outside Codespaces"
fi
[[ ! -e "$HOME/.config" ]] || fail "non-Codespaces run changed configs"
echo "PASS: non-Codespaces guard"

if command -v nvim >/dev/null; then
    new_home parser-lua-error
    export MOCK_REAL_NVIM="$(command -v nvim)"
    if PATH="$test_dir/bin:$PATH" bash "$repo/nvim/.config/nvim/plugins.sh" >"$HOME/install.log" 2>&1; then
        fail "Neovim Lua error incorrectly reported success"
    fi
    grep -q "module 'nvim-treesitter' not found" "$HOME/install.log" ||
        fail "expected missing-module Lua error"
    unset MOCK_REAL_NVIM
    echo "PASS: real Neovim Lua errors propagate"
fi

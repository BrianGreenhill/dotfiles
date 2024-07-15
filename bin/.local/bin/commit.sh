#!/usr/bin/env bash

set -e

function help() {
    echo "========================================="
    echo " [Commit] - commit dotfiles changes"
    echo ""
    echo "Requires: git, DOTFILES env variable"
    echo "and config.nvim directory"
    echo ""
    echo "Usage: commit.sh [dot|nvim|all]"
    echo "========================================="
    exit 1
}

function commitDot() {
    pushd "$DOTFILES"
    git submodule foreach git pull origin main
    git add .
    git commit -m "another dotfiles commit..."
    git push origin main
    popd
}

function commitNvim() {
    pushd ~/Projects/Personal/config.nvim
    git add .
    git commit -m "another nvim commit..."
    git push origin main
    popd
}

if [[ -z "$1" ]]; then help; fi
if [[ ! -d "$DOTFILES" ]]; then help; fi
if [[ ! -d ~/Projects/Personal/config.nvim ]]; then help; fi

case $1 in
    dot)
        commitDot
        echo "dotfiles commit done..."
        ;;
    nvim)
        commitNvim
        echo "nvim commit done..."
        ;;
    all)
        commitNvim
        commitDot
        echo "all commit done..."
        ;;
    *)
        help
        ;;
esac

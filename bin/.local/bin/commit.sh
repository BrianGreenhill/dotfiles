#!/usr/bin/env bash

set -e

function help() {
    echo ' slowman - a slow but powerful pokemon'
    echo ""
    echo "  [commit.sh] - commit dotfiles changes"
    echo ""
    echo " Usage:"
    echo "  commit.sh dot - commit dotfiles"
    echo "  commit.sh obsidian - commit obsidian"
    exit 1
}

function _changes_made() {
    changes_made=$(git status --porcelain)
    if [[ -z "$changes_made" ]]; then
        echo "No changes to commit..."
        exit 0
    fi
}

if [[ -z "$1" ]]; then help; fi

function commit() {
    pushd "$1"
    _changes_made
    git add .
    git commit -m "[automated] sync from commit.sh"
    git push origin main
    popd
}

case $1 in
    dot)
        commit "$HOME/work/briangreenhill/dotfiles"
        echo "dotfiles commit done..."
        ;;
    obsidian)
        commit "$HOME/Documents/obsidian/hoard"
        commit "$HOME/Documents/obsidian/github"
        echo "obsidian commit done..."
        ;;
    *)
        help
        ;;
esac

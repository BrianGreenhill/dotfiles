#!/usr/bin/env bash

set -e

DOTFILES_DIR=${DOTFILES_DIR:-"$HOME/work/briangreenhill/dotfiles"}

function help() {
    echo ' slowman - a slow but powerful pokemon'
    echo ""
    echo "  [commit.sh] - commit dotfiles changes"
    echo ""
    echo " Usage:"
    echo "  commit.sh dot - commit dotfiles"
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
        echo $DOTFILES_DIR
        commit "$DOTFILES_DIR"
        echo "dotfiles commit done..."
        ;;
    *)
        help
        ;;
esac

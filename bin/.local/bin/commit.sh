#!/usr/bin/env bash

set -e

function help() {
    echo '=========================================================='
    echo '         ______                                         '
    echo '  __________  /________      ________ _________ _______ '
    echo '  __  ___/_  /_  __ \_ | /| / /_  __ `__ \  __ `/_  __ \'
    echo '  _(__  )_  / / /_/ /_ |/ |/ /_  / / / / / /_/ /_  / / /'
    echo '  /____/ /_/  \____/____/|__/ /_/ /_/ /_/\__,_/ /_/ /_/'
    echo ""
    echo "  [commit.sh] - commit dotfiles changes"
    echo ""
    echo " Usage:"
    echo "  commit.sh dot - commit dotfiles"
    echo "  commit.sh nvim - commit nvim"
    echo "  commit.sh obsidian - commit obsidian"
    echo ""
    echo '========================================================='
    exit 1
}

if [[ -z "$1" ]]; then help; fi

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

function commitObsidian() {
    pushd ~/Projects/Personal/hoard
    git add .
    git commit -m "another obsidian commit..."
    git push origin main
    popd
}


case $1 in
    dot)
        commitDot
        echo "dotfiles commit done..."
        ;;
    nvim)
        commitNvim
        echo "nvim commit done..."
        ;;
    obsidian)
        commitObsidian
        echo "obsidian commit done..."
        ;;
    *)
        help
        ;;
esac

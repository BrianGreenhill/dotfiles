#!/bin/zsh
set -euo pipefail

function checkdeps {
    deps="utf8proc libtool libevent git cmake autoconf automake m4 perl pkg-config"
    for dep in $deps; do
        echo "checking for $dep..."
        if ! brew list $dep &>/dev/null; then
            echo "missing $dep"
            exit 1
        fi
    done
}

arg="$1"
if [ ! -z $arg ]; then
    echo "targeting install for $arg"
    install_directories=($arg)
else
    install_directories=(tmux nvim zoxide)
fi

for dir in ${install_directories[@]}; do
    if [ ! -d $dir ]; then
        echo "$dir not found"
        exit 1
    fi

    pushd $dir
    if [ ! -f install ]; then
        echo "no install script found in $dir"
        echo "skipping $dir"
        popd
        continue
    fi
    chmod +x install
    ./install
    popd
done

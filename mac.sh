#!/usr/bin/env bash
set -e

TMUX_VERSION=3.5
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

function installbrew {
    if command -v brew &>/dev/null; then
        return
    fi
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function installtmux {
    if command -v tmux &>/dev/null; then
        echo "tmux already installed"
        return
    fi

    echo "installing tmux..."
    git clone --depth 1 -b $TMUX_VERSION --single-branch https://github.com/tmux/tmux tmux-repo
    pushd tmux-repo
    sh autogen.sh
    ./configure --prefix=$HOME/tmux --enable-utf8proc && make && make install
    popd
    rm -rf tmux-repo
    echo "done"
}

function installnvim {
    if command -v nvim &>/dev/null; then
        echo "neovim already installed"
        return
    fi

    echo "installing neovim..."
    rm -rf neovim
    # shallow clone to save time
    git clone -b stable --single-branch --depth 1 https://github.com/neovim/neovim 
    pushd neovim
    make CMAKE_BUILD_TYPE=Release CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
    popd

    rm -rf neovim
    echo "done"
}

case "$1" in
    "checkdeps")
        checkdeps
        ;;
    "brew")
        installbrew
        ;;
    "tmux")
        installtmux
        ;;
    "nvim")
        installnvim
        ;;
    *)
        echo "usage: $0 [checkdeps|brew|tmux|nvim]"
        exit 1
        ;;
esac

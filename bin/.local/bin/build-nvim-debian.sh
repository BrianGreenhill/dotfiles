#!/bin/bash
set -ex

RELEASE=0.10.0

logfile=$(mktemp)
exec 3<>"$logfile"
source_dir=$(mktemp -d)

echo "===> Installing prequisites"
sudo apt update >&3 2>&1
sudo apt-get install --no-install-recommends -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen >&3 2>&1

echo "===> Cloning neovim"
pushd "$source_dir" &>/dev/null
git clone https://github.com/neovim/neovim >&3 2>&1

echo "===> Building neovim $RELEASE and its dependencies"
cd neovim
git checkout v"$RELEASE" >&3 2>&1
make CMAKE_BUILD_TYPE=RelWithDebInfo -j"$(nproc)" >&3 2>&1

echo "===> Installing the new neovim"
sudo make install >&3 2>&1

popd &>/dev/null
exec 3>&-
echo "Please see $logfile for additional output"

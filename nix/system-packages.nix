{ pkgs ? import <nixpkgs> {} }:
with pkgs;[
    htop
    git
    ripgrep
    jq
    yq
    jqp
    tmux
    neovim
    nodejs
    fzf
    eza
    python3
    python3.pkgs.pip
    go_1_22
    delve
]

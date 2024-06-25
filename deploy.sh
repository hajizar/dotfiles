#!/bin/bash

# Use XDG_CONFIG_HOME if set, otherwise default to $HOME/.config
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p $XDG_CONFIG_HOME

# Determine the directory of the script
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# Create symlinks
ln -sf "$DOTFILES_DIR/.config/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$DOTFILES_DIR/.config/nvim" "$XDG_CONFIG_HOME/nvim"

#!/usr/bin/env bash
set -e

DOTFILES="$HOME/repos/dotfiles"

echo "🔗 Linking dotfiles..."

ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

mkdir -p "$HOME/.config"
ln -snf "$DOTFILES/nvim" "$HOME/.config/nvim"
ln -snf "$DOTFILES/i3" "$HOME/.config/i3"

echo "✅ Dotfiles linked successfully."

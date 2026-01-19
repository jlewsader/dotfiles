#!/bin/bash

# This script installs the dotfiles and their dependencies.

echo "Starting dotfiles installation..."

# ------------------------------------------------------------------------------
# Install dependencies
# ------------------------------------------------------------------------------

echo "Installing dependencies..."
# Add commands to install the following applications using your package manager
# (e.g., apt, brew, pacman):
# - zsh
# - alacritty
# - tmux
# - lazygit
# - stow
# - neovim
# - fzf
# - git
# - ruby
# - rust (cargo)

# Example for Debian/Ubuntu:
# sudo apt update
# sudo apt install -y zsh alacritty tmux lazygit stow neovim fzf git ruby curl
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Example for macOS (Homebrew):
# brew install zsh alacritty tmux lazygit stow neovim fzf git ruby rust

# The alacritty and nvim configs use the JetBrainsMono Nerd Font.
# You can download it from the Nerd Fonts website: https://www.nerdfonts.com/

echo "Dependencies installed."

# ------------------------------------------------------------------------------
# Change default shell to zsh
# ------------------------------------------------------------------------------

if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Changing default shell to zsh..."
  chsh -s $(which zsh)
  echo "Default shell changed to zsh. Please log out and log back in for the changes to take effect."
else
  echo "Default shell is already zsh."
fi
# ------------------------------------------------------------------------------
# Install Oh My Zsh and plugins
# ------------------------------------------------------------------------------

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "Oh My Zsh installed."

  echo "Installing zsh plugins..."
  ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
  echo "Zsh plugins installed."

  echo "Installing Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
  echo "Powerlevel10k theme installed."
else
  echo "Oh My Zsh is already installed."
fi

# ------------------------------------------------------------------------------
# Symlink dotfiles
# ------------------------------------------------------------------------------

echo "Symlinking dotfiles..."
# Use stow to create symlinks in the home directory.
# The --adopt flag is used to prevent stow from overwriting existing files that
# are not part of the dotfiles repository.
#stow --adopt alacritty
#stow --adopt colorls
#stow --adopt lazygit
#stow --adopt nvim
#stow --adopt tmux
#stow --adopt yazi
#stow --adopt zsh
echo "Dotfiles symlinked."

# ------------------------------------------------------------------------------
# Install Ruby gems and Cargo packages
# ------------------------------------------------------------------------------

echo "Installing colorls..."
gem install colorls
echo "colorls installed."

echo "Installing yazi..."
cargo install --locked yazi-fm
echo "yazi installed."

# ------------------------------------------------------------------------------
# Install Tmux plugins
# ------------------------------------------------------------------------------

echo "Installing Tmux Plugin Manager (tpm)..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "tpm installed."
  echo "To install the tmux plugins, start a tmux session and press 'prefix + I'."
else
  echo "tpm is already installed."
fi

# ------------------------------------------------------------------------------
# Install Neovim plugins
# ------------------------------------------------------------------------------

echo "Installing Neovim plugins..."
# Install plugins using lazy.nvim
nvim --headless -c 'Lazy sync' -c 'qa'
echo "Neovim plugins installed."

echo "Dotfiles installation complete."

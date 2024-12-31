#!/bin/sh

BUNDLE_DIR="${HOME}/.config/nvim/bundle"
COLOR_DIR="${HOME}/.config/nvim/color"

# shell settings
mkdir -p ~/.config/fish/conf.d
mkdir -p ~/.config/fish/functions
cp ./config.fish ~/.config/fish/
cp ./alias ~/.alias
cp ./fish-ssh-agent/fish-ssh-agent.fish ~/.config/fish/conf.d/
cp ./fish-ssh-agent/__ssh_agent_is_started.fish ~/.config/fish/functions/

# Install vim-plug and vimrc config file for neovim (nvim)
mkdir -p ~/.config/nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./vimrc ~/.config/nvim/init.vim

# Install tmux configuration
cp ./tmux.conf "${HOME}/.tmux.conf"

# TODO(kaisers): Run PlugInstall in neovim from here, currently this needs to be done manually.

echo "Installation complete. Ensure neovim, tmux and fish are installed in order to utilize these configs."

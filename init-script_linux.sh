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

# create git tree alias
git config --global alias.tree "log --oneline --decorate --all --graph"

# Install vim-plug and vimrc config file for neovim (nvim)
mkdir -p ~/.config/nvim/venv
#sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
#       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./vimrc.lua ~/.config/nvim/init.lua
python3 -m venv  ~/.config/nvim/venv
source ~/.config/nvim/venv/bin/activate
pip3 install -U pynvim neovim tomlkit platformdirs mccabe isort dill astroid pylint
deactivate

# Install tmux configuration
cp ./tmux.conf "${HOME}/.tmux.conf"

# Install user ruff config
mkdir -p ~/.config/ruff/
cp ./pyproject.toml ~/.config/ruff/pyproject.toml

echo "Installation complete. Ensure tmux and fish are installed in order to utilize these configs."

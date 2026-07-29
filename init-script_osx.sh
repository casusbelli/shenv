#!/bin/sh

BUNDLE_DIR="${HOME}/.config/nvim/bundle"
COLOR_DIR="${HOME}/.config/nvim/color"

# initially run default linux ops
./init-script_linux.sh

# tmux config file is OS X specific
cp ./tmux.conf.osx "${HOME}/.tmux.conf"

# I'm using light terminals on OS X, force nvim to use this
sed -i '' 's/^vim\.o\.background = \"dark\"/vim.o.background = \"light\"/g' ~/.config/nvim/init.lua

# OS X path for fish differs from linux
sed -i '' 's/\/usr\/local\/bin\/fish/\/opt\/homebrew\/bin\/fish/g' ~/.tmux.conf

# replace gpt 2 with gwen on OS X host for shellai
sed -i '' 's/gpt-oss:20b/qwen3.6:35b/g' ~/.config/fish/config.fish

# Report we're done here
echo "OS X specific adaptions done."


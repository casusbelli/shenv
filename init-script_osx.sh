#!/bin/sh

BUNDLE_DIR="${HOME}/.config/nvim/bundle"
COLOR_DIR="${HOME}/.config/nvim/color"

# initially run default linux ops
./init-script_linux.sh

# now overwrite osx specific settings

# shell settings
mkdir -p ~/.config/fish/
cp ./config.fish.osx ~/.config/fish/config.fish

# tmux config file is OS X specific
cp ./tmux.conf.osx "${HOME}/.tmux.conf"

# I'm using light terminals, force nvim to use this
echo "set background=light" > ~/.config/nvim/init.vim

# Repoprt we're done here
echo "OS X specific adaptions done."


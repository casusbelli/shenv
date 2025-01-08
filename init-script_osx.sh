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

# I'm using light terminals on OS X, force nvim to use this
sed -i '' 's/^set background=dark/set background=light/g' ~/.config/nvim/init.vim

# OS X path for fish differs from linux
sed -i '' 's/\/usr\/local\/bin\/fish/\/opt\/homebrew\/bin\/fish/g' ~/.tmux.conf

# Repoprt we're done here
echo "OS X specific adaptions done."


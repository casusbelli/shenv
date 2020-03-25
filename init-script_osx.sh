#!/bin/sh

BUNDLE_DIR="${HOME}/.config/nvim/bundle"
COLOR_DIR="${HOME}/.config/nvim/color"

# initially run default linux ops
./init-script_linux.sh

# now overwrite osx specific settings

# shell settings
mkdir -p ~/.config/fish/
cp ./config.fish.osx ~/.config/fish/config.fish

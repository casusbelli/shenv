#!/bin/sh

# Enable VIM pathogen plugin manager for neovim
mkdir -p ~/.config/nvim/autoload ~/.config/nvim/bundle
wget "https://www.vim.org/scripts/download_script.php?src_id=16224" --output-document ~/.config/nvim/autoload/pathogen.vim
rm "download_script.php?src_id=16224"

# Install vimrc config file for neovim (nvim)
#cp --no-clobber ./vimrc ~/.config/nvim/init.vim
cp ./vimrc ~/.config/nvim/init.vim

# Install fugitive plugin
mkdir -p  ~/.config/nvim/bundle/vim-fugitive
git clone https://github.com/tpope/vim-fugitive ~/.config/nvim/bundle/vim-fugitive/
ls -lah ~/.config/nvim/bundle/


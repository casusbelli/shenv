#!/bin/sh

BUNDLE_DIR="${HOME}/.config/nvim/bundle"

# Enable VIM pathogen plugin manager for neovim
mkdir -p ~/.config/nvim/autoload "$BUNDLE_DIR"
wget "https://www.vim.org/scripts/download_script.php?src_id=16224" --output-document ~/.config/nvim/autoload/pathogen.vim

# Install vimrc config file for neovim (nvim)
cp ./vimrc ~/.config/nvim/init.vim

echo "Installing vim plugins..."
# Install fugitive plugin
mkdir -p  "${BUNDLE_DIR}/vim-fugitive"
git clone https://github.com/tpope/vim-fugitive "${BUNDLE_DIR}/vim-fugitive/"
# Install syntastic plugin
mkdir -p  "${BUNDLE_DIR}/syntastic"
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git "${BUNDLE_DIR}/syntastic/"
# Install vim-go (once centos provides neovim 3.2+)
#mkdir -p  "${BUNDLE_DIR}/vim-go"
#git clone https://github.com/fatih/vim-go.git "${BUNDLE_DIR}/vim-go/"
# Install vim-markdown
mkdir -p  "${BUNDLE_DIR}/vim-markdown"
git clone https://github.com/plasticboy/vim-markdown.git "${BUNDLE_DIR}/vim-markdown/"
# Install trailing-whitespace
mkdir -p  "${BUNDLE_DIR}/trailing-whitespace"
git clone http://github.com/bronson/vim-trailing-whitespace "${BUNDLE_DIR}/trailing-whitespace/"
# Install python-mode
mkdir -p  "${BUNDLE_DIR}/python-mode"
git clone --recurse-submodules https://github.com/python-mode/python-mode "${BUNDLE_DIR}/python-mode/"
echo "vim plugin installation done."

# Install tmux configuration
cp ./tmux.conf "${HOME}/.tmux.conf"

echo "Installation complete. Ensure neovim, tmux and fish are installed in order to utilize these configs."

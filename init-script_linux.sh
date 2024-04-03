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

# Enable VIM pathogen plugin manager for neovim
mkdir -p ~/.config/nvim/autoload "$BUNDLE_DIR" "$COLOR_DIR"
wget "https://tpo.pe/pathogen.vim" --output-document ~/.config/nvim/autoload/pathogen.vim

# Install vimrc config file for neovim (nvim)
cp ./vimrc ~/.config/nvim/init.vim

echo "Installing vim plugins..."
# Install fugitive plugin
mkdir -p  "${BUNDLE_DIR}/vim-fugitive"
git clone https://github.com/tpope/vim-fugitive "${BUNDLE_DIR}/vim-fugitive/"
# Install syntastic plugin
#mkdir -p  "${BUNDLE_DIR}/syntastic"
#git clone --depth=1 https://github.com/vim-syntastic/syntastic.git "${BUNDLE_DIR}/syntastic/"
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
# Install youcompleteme, uncomment once compatible with centos current nvim package
#mkdir -p  "${BUNDLE_DIR}/youcompleteme"
#git clone https://github.com/valloric/youcompleteme "${BUNDLE_DIR}/youcompleteme/"
# Install vim-airline and themes
mkdir -p  "${BUNDLE_DIR}/vim-airline" "${BUNDLE_DIR}/vim-airline-themes"
git clone https://github.com/bling/vim-airline "${BUNDLE_DIR}/vim-airline/"
git clone https://github.com/vim-airline/vim-airline-themes "${BUNDLE_DIR}/vim-airline-themes/"
# Install ale plugin
mkdir -p  "${BUNDLE_DIR}/ale"
git clone https://github.com/dense-analysis/ale "${BUNDLE_DIR}/ale/"
# Install vim-colorschemes plugin
mkdir -p  "${BUNDLE_DIR}/vim-colorschemes"
git clone https://github.com/flazz/vim-colorschemes "${BUNDLE_DIR}/vim-colorschemes/"
# Install jedi-vim plugin
mkdir -p  "${BUNDLE_DIR}/jedi-vim"
git clone --recursive https://github.com/davidhalter/jedi-vim.git "${BUNDLE_DIR}/jedi-vim/"
# Install nvim-yarp plugin
mkdir -p  "${BUNDLE_DIR}/nvim-yarp"
git clone https://github.com/roxma/nvim-yarp.git "${BUNDLE_DIR}/nvim-yarp/"
# Install ncm2 plugin
mkdir -p  "${BUNDLE_DIR}/ncm2"
git clone https://github.com/ncm2/ncm2.git "${BUNDLE_DIR}/ncm2/"
# Install ncm2-jedi plugin
mkdir -p  "${BUNDLE_DIR}/ncm2-jedi"
git clone https://github.com/hanspinckaers/ncm2-jedi.git "${BUNDLE_DIR}/ncm2-jedi/"
# Install ncm2-bufword plugin
mkdir -p  "${BUNDLE_DIR}/ncm2-bufword"
git clone https://github.com/ncm2/ncm2-bufword.git "${BUNDLE_DIR}/ncm2-bufword/"
# Install vim-hcl plugin
mkdir -p  "${BUNDLE_DIR}/vim-hcl"
git clone https://github.com/jvirtanen/vim-hcl.git "${BUNDLE_DIR}/vim-hcl/"
echo "vim plugin installation done."

# Install tmux configuration
cp ./tmux.conf "${HOME}/.tmux.conf"

echo "Installation complete. Ensure neovim, tmux and fish are installed in order to utilize these configs."

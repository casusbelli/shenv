echo "Setting up neovim"

" Cleanup and install vim-plug based plugins
PlugClean
PlugInstall

"Conqueror of Completion - install additional packages
CocInstall coc-groovy coc-java

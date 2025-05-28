
" Create Python 3 venv and install pynvim if it is not already installed.
let g:python3_host_prog='~/.config/nvim/venv/bin/python3'

call plug#begin("~/.config/nvim/bundle")
" List your plugins here

Plug 'tpope/vim-sensible'
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'plasticboy/vim-markdown'
Plug 'bronson/vim-trailing-whitespace'
Plug 'dense-analysis/ale'
Plug 'jvirtanen/vim-hcl'
Plug 'davidhalter/jedi-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

set ruler
set cursorline

" Set encoding
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Disable Mode Display because Status line is on
set noshowmode

" Show trailing spaces and highlight hard tabs
set list listchars=tab:»·,trail:·

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Disable code folding
set nofoldenable

" Always show status bar
set laststatus=2

" make uses real tabs
au FileType make set noexpandtab

" Ruby uses 2 spaces
au FileType ruby set softtabstop=2 tabstop=2 shiftwidth=2

" Go uses tabs
au FileType go set noexpandtab tabstop=4 shiftwidth=4

" Go Foo
let g:go_fmt_command = "goimports"

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
au FileType ruby   set softtabstop=2 tabstop=2 shiftwidth=2

" Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Provide ALE configuration
let g:airline#extensions#ale#enabled = 1
let g:ale_fixers = {'python': ['isort', 'remove_trailing_lines', 'trim_whitespace']}
" Also we want to use other code completion systems instead of ale.
let g:ale_completion_enabled = 0

" set colorscheme
colorscheme gruvbox

" Do not use visual mode on mouse marking text but use classic behaviour
set mouse=v

" I used to use dark terminals with Linux
" set background=dark
set background=light

" Set space as mapleader key
let mapleader="\<Space>"

" Set <cr> as coc completion key
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

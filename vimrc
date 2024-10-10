
" Pathogen load
filetype off

call pathogen#infect()
call pathogen#helptags()

filetype plugin indent on
syntax on

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

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
au FileType ruby   set softtabstop=2 tabstop=2 shiftwidth=2

" yaml should use spaces instead of tabs
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" Use Ag instead of Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" syntastic configuration
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Provide ALE configuration
let g:airline#extensions#ale#enabled = 1

" set colorscheme
colorscheme gruvbox

" Add NCM2 based autocompletions
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Do not use visual mode on mouse marking text but use classic behaviour
set mouse=v

" I use dark terminals with Linux
set background=dark

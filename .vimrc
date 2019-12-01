syntax on " enabled syntax highlighting

set nocompatible
set backspace=indent,eol,start
set history=100
set ruler
set showcmd                     " show incomplete commands
set number                      " line numbers
set ai                          " autoindent
set incsearch                   " incremental searching
set nowrap                      " never wrap lines
set autoindent                  " always indent
set esckeys                     " Allow cursor keys in insert mode
set ttyfast                     " optimized for fast terminals
set encoding=utf-8 nobomb       " use UTF-8 without BOM
set mouse=a                     " Enable mouse in all modes
set noerrorbells
set nostartofline               " Don't reset cursor to start of line when moving around
set showmode                    " Show current mode
set title                       " Show the filename in window titlebar

" don't add empty newlines at the end of the files
set binary
set noeol

set backup

" Centralize backups, swapfiles, and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
set undodir=~/.vim/undo

" Colors and scheme
set background=dark
colorscheme elflord

" DEFAULTS
set tabstop=4                   " sets tabs to 4 characters
set shiftwidth=4
set expandtab
set softtabstop=4               " makes the spaces feel like real tabs

" Highlight current line only in insert mode
autocmd InsertLeave * set nocursorline
autocmd InsertEnter * set cursorline

" Makefiles require TAB instead of whitespace
autocmd FileType make setlocal noexpandtab

" Highlight cursor
highlight CursorLine ctermbg=8 cterm=NONE

" Load a local configuration file if it exists
if filereadable(".vimrc.local")
    source .vimrc.local
endif

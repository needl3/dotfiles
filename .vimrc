" ----------------------Settings Section---------------------
syntax on
filetype plugin indent on
set nocompatible
set hidden
set encoding=utf-8
set cursorline
set number
set scrolloff=0
set mouse=a
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set autoread
set noshowmode
let mapleader=","
" Custom command
command! Wwq :w|bd

nnoremap <C-n> :enew <CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <C-f> :Rg<CR>

cnoreabbrev wq Wwq

if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard
    if has("unnamedplus") " X11 support
        set clipboard+=unnamedplus
    endif
endif
" ----------------------Variables Section---------------------
:colorscheme koehler

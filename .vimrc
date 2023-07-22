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

" ----------------------Plugin Section---------------------
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree' " Directory Browser
" Plug 'vim-airline/vim-airline' " Vim bottom bar
" Plug 'vim-airline/vim-airline-themes' " Vim bottom bar
" Plug 'tpope/vim-fugitive' " Git Info for Airline
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " For Files command for fuzzy search
call plug#end()


" ----------------------Mapping Section---------------------
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-n> :enew <CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-p> :call FZFProjectRoot()<CR>
nnoremap <Leader><space> :let $VIMDIR=expand('%:p:h')<CR>:term<CR>cd $VIMDIR<CR>

cnoreabbrev wq Wwq


" search from the git root if we're in a git repo
function! FZFProjectRoot()
    let project_root = system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
    if strlen(project_root) > 0
        call fzf#run(fzf#wrap('FZFProjectRoot', {'dir': project_root}))
    else
        call fzf#run(fzf#wrap('FZFProjectRoot'))
    endif
endfunction

if has("clipboard")
    set clipboard=unnamed " copy to the system clipboard
    if has("unnamedplus") " X11 support
        set clipboard+=unnamedplus
    endif
endif
" ----------------------Variables Section---------------------
:colorscheme koehler

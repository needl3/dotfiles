" ----------------------Settings Section---------------------
syntax on
filetype plugin indent on
set nocompatible
set ts=2 sts=2 sw=2 et ai si

set encoding=utf-8
set number
set relativenumber
"
" Highlight cursor line
set cursorline
set shiftwidth=4
set tabstop=4
" Donot change cursor line while scrolling
set scrolloff=0
set nowrap
set autoindent
set smarttab
set mouse=a
let mapleader=","

" ----------------------Plugin Section---------------------
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree' " Directory Browser
Plug 'vim-airline/vim-airline' " Vim bottom bar
Plug 'vim-airline/vim-airline-themes' " Vim bottom bar
Plug 'tpope/vim-fugitive' " Git Info for Airline
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'do': 'npm install' }	" Autocompletion
Plug 'prettier/vim-prettier'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " For Files command for fuzzy search

call plug#end()


" ----------------------Mapping Section---------------------
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-n> :enew <CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
nnoremap <C-w> :w\|bd<cr>
nnoremap <C-f> :FZF -e<CR>
nnoremap <C-f>b :call fzf#vim#buffers()<CR>
nnoremap <C-p> :call FZFProjectRoot()<CR>

" use <tab> for trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

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
:colorscheme desert

" ---------------------Airline Configuration-----------------
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

" unicode symbols
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_right_sep = ''

let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '  '
let g:airline_extensions = ['branch', 'tabline']
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = "\uE0B8"
let g:airline#extensions#tabline#right_sep = "\uE0BA"
let g:airline#extensions#tabline#formatter = 'unique_tail'

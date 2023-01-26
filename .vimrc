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
Plug 'vim-airline/vim-airline' " Vim bottom bar
Plug 'vim-airline/vim-airline-themes' " Vim bottom bar
Plug 'tpope/vim-fugitive' " Git Info for Airline
Plug 'ap/vim-css-color'
Plug 'neoclide/coc.nvim', {'do': 'yarn' }	" Autocompletion
Plug 'prettier/vim-prettier', {'do': 'yarn', 'for': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact']}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " For Files command for fuzzy search
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()


" ----------------------Mapping Section---------------------
nnoremap <C-b> :NERDTreeToggle<CR>
nnoremap <C-n> :enew <CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>
" nnoremap <C-f>b :call fzf#vim#buffers()<CR>
nnoremap <C-f> :Rg<CR>
nnoremap <C-p> :call FZFProjectRoot()<CR>
nnoremap <Leader><space> :let $VIMDIR=expand('%:p:h')<CR>:term<CR>cd $VIMDIR<CR>

cnoreabbrev wq Wwq

" Press Tab and Shift+Tab and navigate around completion selections
function! CheckBackspace() abort
  let col = col('.') -1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction


inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <S-Tab>
  \ coc#pum#visible() ? coc#pum#next(-1) :
  \ CheckBackspace() ? "\<S-Tab>" :
  \ coc#refresh()

" Press Enter to select completion items or expand snippets
inoremap <silent><expr> <CR>
  \ coc#pum#visible() ? coc#pum#confirm() :
  \ "\<C-g>u\<CR>"

let g:coc_snippet_next = '<Tab>'              " Use Tab to jump to next snippet placeholder
let g:coc_snippet_prev = '<S-Tab>'            " Use Shift+Tab to jump to previous snippet placeholder
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

" ----------------------Vim prettier autoformat---------------
let g:prettier#autoformat = 1
let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#quickfix_enabled = 0

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

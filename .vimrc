" ----------------------Settings Section---------------------
set encoding=utf-8
set number
set relativenumber
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

" ----------------------Plugin Section---------------------
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree' " Directory Browser
Plug 'vim-airline/vim-airline' " Vim bottom bar
Plug 'ap/vim-css-color'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ycm-core/YouCompleteMe' " Autocompleteion support
Plug 'sainnhe/gruvbox-material' " GruvBox theme

call plug#end()


" ----------------------Mapping Section---------------------
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-i> :PlugInstall<CR>
" }}}

" ----------------------Variables Section---------------------
set background=dark
:colorscheme gruvbox


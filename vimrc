" NOTE: You would think this file is not needed given my neovim config, but it's still used by VS Code.

let mapleader=" "

syntax enable
filetype plugin indent on

" Display line numbers
set number
set relativenumber

" Always show the status bar
set laststatus=2

" Enable mouse support
"set mouse=a 

" Use spaces instead of tabs
set expandtab
" A single tab equals four spaces
set tabstop=4
set shiftwidth=4

" Ignore case when searching
set ignorecase
" A search term containing a capital letter triggers a case sensitive search
set smartcase
" Highlight search results
" set hlsearch

" Fix the Backspace key on Mac
set backspace=indent,eol,start

" Word wrap without line breaks
set wrap
set linebreak

" ==============================================================================
" =============================== KEYBINDINGS ==================================
" ==============================================================================

nmap <leader>d :q<CR>
nmap <leader>s :w<CR>

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Do not copy selection when pasting
nmap <leader>p "0p<CR>
vmap <leader>p "0p<CR>

" Remove search highlights
nnoremap <silent> <C-l> :nohl<CR><C-l>

nmap <leader>m :marks<CR>

" to avoid having to copy lines into the + register first (on mac)
set clipboard=unnamed

" jump to match while entering search pattern
set incsearch

" replace selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

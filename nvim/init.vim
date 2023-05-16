lua require('packer-config')
lua require('tree-config')
lua require('telescope-config')

let mapleader=" "

colorscheme gruvbox

syntax enable
filetype plugin indent on

" Display line numbers
set number
set relativenumber

" Always show the status bar
set laststatus=2

" Enable mouse support
set mouse=a 

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

" to avoid having to copy lines into the + register first (on mac)
set clipboard=unnamed

" jump to match while entering search pattern
set incsearch

" ==============================================================================
" =============================== KEYBINDINGS ==================================
" ==============================================================================

nmap <leader>d :q<CR>
nmap <leader>s :w<CR>

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Remove search highlights
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files hidden=true<cr>
nnoremap <C-p> <cmd>Telescope git_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

" nvim tree 
nnoremap <C-n> <cmd>NvimTreeToggle<cr>

"nnoremap <leader>d "_d
"vnoremap <leader>d "_d

" move selected lines up and down
vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv

" replace selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

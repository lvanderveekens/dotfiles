" ==============================================================================
" ================================= PLUGINS ====================================
" ==============================================================================

call plug#begin()

Plug 'scrooloose/nerdtree' 
Plug 'vim-airline/vim-airline' 
Plug 'altercation/vim-colors-solarized' 
Plug 'vim-airline/vim-airline-themes' 
Plug 'mxw/vim-jsx' 
Plug 'pangloss/vim-javascript' 
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go'
Plug 'Raimondi/delimitMate'
Plug 'kien/ctrlp.vim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

call plug#end()

" ==============================================================================
" ================================= SETTINGS ===================================
" ==============================================================================

syntax enable
filetype plugin indent on

"colorscheme solarized
set background=dark


" Display line numbers
set number
set relativenumber
"
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

" Use 256 colors
" set t_Co=256

" Fix the Backspace key on Mac
set backspace=indent,eol,start

" Enable JSX syntax highlighting and indentation in .js files
let g:jsx_ext_required = 0

" Word wrap without line breaks
set wrap
set linebreak

" ==============================================================================
" =============================== KEYBINDINGS ==================================
" ==============================================================================

" Open a new empty buffer
nmap <leader>T :enew<cr>
" Close the current buffer
nmap <leader>d :bd<CR>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Recognize .adoc files as asciidoc files 
autocmd BufNewFile,BufRead *.adoc set filetype=asciidoc
" Recognize .log files as log4j files
autocmd BufNewFile,BufRead *.log* set syntax=log4j

" Remove search highlights
nnoremap <silent> <C-l> :nohl<CR><C-l>

" ==============================================================================
" =========================== PLUGIN CONFIGURATION =============================
" ==============================================================================

" ==== CTRLP.VIM 

" Use the nearest .svn directory as the cwd
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth=40

" ==== VIM-AIRLINE 

" Grab a Powerline font from 'https://github.com/powerline/fonts'
" and configure it as the 'Monospace' font in gnome-tweak-tool
" let g:airline_powerline_fonts=1
"let g:airline_theme="powerlineish"
"let g:airline_theme="solarized"

" ==== ULTISNIPS 

" Insert a snippet
let g:UltiSnipsExpandTrigger="<tab>"

" ==== DELIMITMATE 

" Move the closing bracket one line below the cursor after pressing Enter
let delimitMate_expand_cr=1

" ==== NERDTREE

" Toggle the tree 
map <C-n> :NERDTreeToggle<CR>
" let g:NERDTreeWinSize = 40
  
" ==== VIM-GO 

let g:go_highlight_space_tab_error = 0
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_extra_types = 0
let g:go_highlight_build_constraints = 1
let g:go_highlight_types = 0
let g:go_highlight_structs = 1  
let g:go_highlight_operators = 1  
let g:go_highlight_build_constraints = 1  

" Ignore the VIM version warning vim-go complains about
let g:go_version_warning = 0

autocmd FileType go nmap <leader>b :GoBuild<CR>
autocmd FileType go nmap <leader>r :GoRun<CR>
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" to avoid having to copy lines into the + register first (on mac)
set clipboard=unnamed

" jump to match while entering search pattern
set incsearch

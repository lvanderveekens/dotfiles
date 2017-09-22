execute pathogen#infect()

syntax enable
filetype plugin indent on
colorscheme Tomorrow-Night

" set cursorline
" hi CursorLine cterm=NONE ctermbg=NONE ctermfg=white

set number
" allow status bar to always show.
set laststatus=2

" use the mouse to move the cursor
set mouse=a " always use spaces instead of tabs
set expandtab
" one tab is four spaces
set tabstop=4

" Use capital letters to do a case sensitive search
set ignorecase
set smartcase

" use 256 colors
set t_Co=256
" let g:solarized_termcolors=256

" Use the nearest .svn directory as the cwd
" This makes a lot of sense if you are working on a project 
" that is in version control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth=40

" airline plugin
"let g:airline_powerline_fonts=1
let g:airline_theme="tomorrow"
" let g:airline_theme="base16"
" enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" just show the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" insert a snippet
let g:UltiSnipsExpandTrigger="<tab>"

" end bracket one line below cursor after an enter
let delimitMate_expand_cr=1

" size of an 'indent'
set shiftwidth=4
" vertical line indent
let g:indentLine_color_term=120 
let g:indentLine_char='|'

" CUSTOM KEYBINDINGS 
"
" toggle nerd tree plugin
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 40
  
" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Close the current buffer
nmap <leader>d :bd<CR>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" turn off omni sql auto complete 
let g:omni_sql_no_default_maps=1

" recognize .adoc files as asciidoc files 
autocmd BufNewFile,BufRead *.adoc set filetype=asciidoc
" recognize .log files as log4j files
autocmd BufNewFile,BufRead *.log* set syntax=log4j

" Highlight search results
set hlsearch
" Redraws the screen and removes any seach highlighting 
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Set the color of the search results
hi Search ctermfg=black ctermbg=white

" Hide buffers that are modified
"set hidden

" Use the nearest .svn directory as the cwd
" This makes a lot of sense if you are working on a project 
" that is in version control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'ra'
" No file limit
let g:ctrlp_max_files = 0

" Enable JSX syntax highlighting and indentation in .js files
let g:jsx_ext_required = 0

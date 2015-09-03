execute pathogen#infect()

syntax enable
filetype plugin indent on
set number
" allow status bar to always show.
set laststatus=2

" use the mouse to move the cursor
set mouse=a
" always use spaces instead of tabs
set expandtab
" one tab is four spaces
set tabstop=4
" use 256 colors
set t_Co=256
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
 
"
" airline plugin
let g:airline_powerline_fonts=1
let g:airline_theme="sol"

" insert a snippet
let g:UltiSnipsExpandTrigger="<tab>"

" end bracket one line below cursor after an enter
let delimitMate_expand_cr=1

" size of an 'indent'
set shiftwidth=4
" vertical line indent
let g:indentLine_color_term=120 
let g:indentLine_char='|'

" toggle nerd tree plugin
map <C-n> :NERDTreeToggle<CR>

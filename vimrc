execute pathogen#infect()

syntax enable
filetype plugin indent on
set number

" use the mouse to move the cursor
set mouse=a
" size of an 'indent'
set shiftwidth=4
" always use spaces instead of tabs, one tab is four spaces
set expandtab
set tabstop=4

" use 256 colors
set t_Co=256
let g:solarized_termcolors=256
set background=light
colorscheme solarized

" allow status bar to always show.
set laststatus=2

" use the powerline fonts
let g:airline_powerline_fonts=1

" insert a snippet
let g:UltiSnipsExpandTrigger="<tab>"

let delimitMate_expand_cr=1

" toggle nerd tree plugin
map <C-n> :NERDTreeToggle<CR>

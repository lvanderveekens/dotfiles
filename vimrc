execute pathogen#infect()

syntax on
filetype plugin indent on
set number

" Use the mouse to move the cursor
set mouse=a
" Size of an 'indent'
set shiftwidth=4
" Always use spaces instead of tabs
set expandtab

" Let VIM use 256 colors and pick a colorscheme
set t_Co=256

" Allow status bar to always show.
set laststatus=2

" Use the powerline fonts
let g:airline_powerline_fonts=1

" Toggle nerd tree plugin
map <C-n> :NERDTreeToggle<CR>

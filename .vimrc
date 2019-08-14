" List all plugins :PlugInstall
call plug#begin('~/.vim/plugged')
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'altercation/vim-colors-solarized'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'sheerun/vim-polyglot'
  Plug 'ngmy/vim-rubocop'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'ajh17/VimCompletesMe'
  Plug 'Yggdroot/indentLine'
  Plug 'godlygeek/tabular'
  Plug 'scrooloose/nerdcommenter'
  Plug 'thoughtbot/vim-rspec'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'branch': 'release/1.x', 'for': ['javascript'] }
call plug#end()

" prettier settings
let g:prettier#autoformat = 0
autocmd BufWritePre *.js PrettierAsync

" Show hidden files in Ctrl-P
let g:ctrlp_show_hidden = 1

" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" vim-airline settings
let g:airline_detect_spell=0
let g:airline_inactive_collapse=1

" vim-airline-theme settings
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

" nerdcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden=1

" vimrubocop settings
let g:vimrubocop_config = "~/Code/Work/currica/hound/config/style_guides/ruby.yml"

" vimrspec settings
let g:rspec_runner = "os_x_iterm"

" let colorscheme set color for indentLine
let g:indentLine_setColors = 0

" Spell check
set spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline

" built-in matchit macro, % for matching do/end & def/end
runtime macros/matchit.vim

" Enable filetype detection and filetype specific settings.
filetype on
filetype indent on
filetype plugin on

" show existing tab with 2 spaces width
set tabstop=2

" when indenting with '>', use 2 spaces width
set shiftwidth=2

" On pressing tab, insert 2 spaces
set expandtab

"Allows backspacing over everything
set backspace=indent,eol,start

"Sets column line at 80
set colorcolumn=80

" Always display the status line
set laststatus=2

syntax enable
set background=dark
set t_Co=256

" solarized options
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
colorscheme solarized

set number
set relativenumber
set cursorline
set hlsearch
set smartcase
set ignorecase
set autoindent
set smartindent
set hidden
set showmatch

vmap <space>y "+y
map <space>p "+p

let mapleader=','

" Tabularize mappings
nmap <Leader>a= :Tab /=/l1l1<CR>
vmap <Leader>a= :Tab /=/l1l1<CR>
nmap <Leader>a: :Tab /:\zs/l0l1<CR>
vmap <Leader>a: :Tab /:\zs/l0l1<CR>
nmap <Leader>a{ :Tab /)\s*\zs{/<CR>
vmap <Leader>a{ :Tab /)\s*\zs{/<CR>

" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" A wrapper function to restore the cursor position, window position,
" and last search after running a command.
function! Preserve(command)
  " Save the last search
  let last_search=@/
  " Save the current cursor position
  let save_cursor = getpos(".")
  " Save the window position
  normal H
  let save_window = getpos(".")
  call setpos('.', save_cursor)

  " Do the business:
  exec 'call ' . a:command . '()'

  " Restore the last_search
  let @/=last_search
  " Restore the window position
  call setpos('.', save_window)
  normal zt
  " Restore the cursor position
  call setpos('.', save_cursor)
endfunction

" Converts all newlines to Unix style.
function! UnixNewlines()
  e ++ff=dos
  setlocal ff=unix
  w
endfunction

" Removes trailing whitespace and blank EOF lines.
function! StripWhitespace()
  " Removes trailing whitespace.
  %s/\s\+$//e
  " Removes blank EOFs.
  silent! %s#\($\n\s*\)\+\%$##
endfunction

"""
" On Open/Save
"""
" Do things when the file is written out.
au BufWritePre * call Preserve("StripWhitespace")

" Automatically sources .vimrc after saving it.
autocmd! bufwritepost .vimrc source %

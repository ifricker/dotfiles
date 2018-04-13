" List all plugins :PlugInstall
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'ngmy/vim-rubocop'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ajh17/VimCompletesMe'

call plug#end()

" Show hidden files in Ctrl-P
let g:ctrlp_show_hidden = 1

" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" vim-airline-theme settings
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

" nerdtree settings
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden=1

" vimrubocop settings
let g:vimrubocop_config = "~/Code/Work/currica/hound/config/style_guides/ruby.yml"

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
set clipboard=unnamed
set showmatch

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

" List all plugins :PlugInstall
call plug#begin('~/.vim/plugged')
  Plug 'airblade/vim-gitgutter'
  Plug 'ajh17/VimCompletesMe'
  Plug 'altercation/vim-colors-solarized'
  Plug 'dense-analysis/ale'
  Plug 'frazrepo/vim-rainbow'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'ngmy/vim-rubocop'
  " Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript'] }
  Plug 'scrooloose/nerdcommenter'
  Plug 'sheerun/vim-polyglot'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-rails'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vim-test/vim-test'
  Plug 'vim-ruby/vim-ruby'
  Plug 'Yggdroot/indentLine'
  " nvim only
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
call plug#end()

let mapleader=','

" vim-rainbow
" let g:rainbow_active = 1 " globally active, call :RainbowToggle

" Tabular mappings
nmap <Leader>a= :Tab /=/l1l1<CR>
vmap <Leader>a= :Tab /=/l1l1<CR>
nmap <Leader>a: :Tab /:\zs/l0l1<CR>
vmap <Leader>a: :Tab /:\zs/l0l1<CR>
nmap <Leader>a{ :Tab /)\s*\zs{/<CR>
vmap <Leader>a{ :Tab /)\s*\zs{/<CR>
nmap <Leader><Ctrl-[> :Tab /)\s*\zs{/<CR>
vmap <Leader><Ctrl-[> :Tab /)\s*\zs{/<CR>

" vim-test settings
" let test#strategy = "dispatch"
let g:test#ruby#use_spring_binstub = 0
let g:test#preserve_screen = 1
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>

" vimrubocop settings
let g:vimrubocop_config = "./.rubocop.yml"
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop<CR>

" ale settings
let g:ale_linters = { 'ruby': ['ruby', 'rubocop'] }
" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" Run linters only when I save files
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" if you don't want linters to run on opening a file
" let g:ale_lint_on_enter = 0
" Disable ALE auto highlights
let g:ale_set_highlights = 0
let g:airline#extensions#ale#enabled = 1

let g:ruby_rubocop_options = "--config ./.rubocop.yml --force-exclusion"

" prettier settings
" Removes comments, cannot figure out
" let g:prettier#config#print_width = 120
" let g:prettier#exec_cmd_path = "~/.vim/plugged/vim-prettier/node_modules/.bin/prettier"
" autocmd BufWritePre *.js PrettierAsync

" nerdcommenter settings
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

" vim-airline settings
let g:airline_detect_spell=0
let g:airline_inactive_collapse=1

" vim-airline-theme settings
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'

" indentLine settigns
let g:indentLine_setColors = 0 " let colorscheme set color for indentLine

" fzf settings
let g:fzf_preview_window = ['up:60%', 'ctrl-/']
" let g:fzf_options = ['--layout=reverse']
map <C-f> <Esc><Esc>:Files!<CR>

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

"Sets column line at 120, previously 80
set colorcolumn=120

" Always display the status line
set laststatus=2

syntax enable
set background=dark
set t_Co=256

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

" solarized options
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
let g:solarized_termcolors=256
let g:solarized_termtrans = 1
colorscheme solarized

" Spell check
set spell spelllang=en_us
hi clear SpellBad
hi SpellBad term=undercurl cterm=underline gui=undercurl guisp=Red

vmap <space>y "+y
map <space>p "+p

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

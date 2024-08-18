set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" List all plugins :PlugInstall
call plug#begin('~/.vim/plugged')
  Plug 'dense-analysis/ale' " Asynchronous Lint Engine
  Plug 'godlygeek/tabular' " Align text
  Plug 'ngmy/vim-rubocop' " Rubocop
  Plug 'scrooloose/nerdcommenter' " Commenter
  Plug 'sheerun/vim-polyglot' " Syntax highlighting
  Plug 'tpope/vim-fugitive' " Git
  Plug 'tpope/vim-endwise' " Endwise
  Plug 'tpope/vim-rails' " Rails
  Plug 'vim-airline/vim-airline' " Airline
  Plug 'vim-airline/vim-airline-themes' " Airline themes
  Plug 'vim-test/vim-test' " Test runner
  Plug 'vim-ruby/vim-ruby' " Ruby
  Plug 'Yggdroot/indentLine' " Indent lines
  Plug 'airblade/vim-gitgutter' " Git gutter

  Plug 'github/copilot.vim'

  " post install (yarn install | npm install) then load plugin only for editing supported files
  Plug 'prettier/vim-prettier', {
    \ 'do': 'yarn install --frozen-lockfile --production',
    \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }

  " nvim only
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " Treesitter
  Plug 'nvim-tree/nvim-web-devicons' " Icons
  Plug 'nvim-lua/plenary.nvim' " Plenary
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' } " Telescope
  Plug 'folke/tokyonight.nvim'
call plug#end()

let mapleader=','

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Tabular mappings
nmap <Leader>a= :Tab /=>/l1l1<CR>
vmap <Leader>a= :Tab /=>/l1l1<CR>
nmap <Leader>a: :Tab /:\zs/l0l1<CR>
vmap <Leader>a: :Tab /:\zs/l0l1<CR>
nmap <Leader>a{ :Tab /)\s*\zs{/<CR>
vmap <Leader>a{ :Tab /)\s*\zs{/<CR>
nmap <Leader><Ctrl-[> :Tab /)\s*\zs{/<CR>
vmap <Leader><Ctrl-[> :Tab /)\s*\zs{/<CR>

" vim-test settings
" let test#strategy = "dispatch"
let g:test#ruby#use_spring_binstub = 0 " Use spring binstub
let g:test#preserve_screen = 1 " Preserve screen
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>

" vimrubocop settings
let g:vimrubocop_config = "./.rubocop.yml" " Use local rubocop config
let g:vimrubocop_keymap = 0 " Disable keymap
nmap <Leader>r :RuboCop<CR>

" ale settings
let g:ale_linters = { 'ruby': ['ruby', 'rubocop'] } " Use rubocop
let g:ale_linters_explicit = 1 " Only run linters named in ale_linters settings.
let g:ale_lint_on_text_changed = 'never' " Don't run linters when I type.
let g:ale_lint_on_insert_leave = 0 " Don't run linters when I leave insert mode.
" let g:ale_lint_on_enter = 0 " Don't run linters when I open a file.
let g:ale_set_highlights = 0 " Don't highlight linter errors.
let g:airline#extensions#ale#enabled = 1 " Show ALE errors in airline.

let g:ruby_rubocop_options = "--config ./.rubocop.yml --force-exclusion" " Use local rubocop config

" nerdcommenter settings
let g:NERDSpaceDelims = 1 " Use space after comment delimiters by default
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation

" vim-airline settings
let g:airline_detect_spell=0 " Don't show spellcheck status in airline.
let g:airline_inactive_collapse=1 " Collapse inactive airline statusline.
let g:airline#extensions#tabline#enabled = 1 " Enable tabline.

" vim-airline-theme settings
let g:airline_powerline_fonts = 1 " Use powerline fonts
let g:airline_theme='solarized' " Use solarized theme

" indentLine settigns
let g:indentLine_setColors = 0 " Disable indentLine colors

runtime macros/matchit.vim " For % and other matchit settings

" Enable filetype detection and filetype specific settings.
filetype on
filetype indent on
filetype plugin on

set tabstop=2 " Insert 2 spaces for a tab.
set shiftwidth=2 " Indentation
set expandtab " Use spaces instead of tabs
set backspace=indent,eol,start " Backspace over everything
set colorcolumn=120 " Highlight column 120
set laststatus=2 " Always display the status line
syntax enable " Enable syntax highlighting
set background=dark " Use dark background
set t_Co=256 " Use 256 colors
set number " Show line numbers
set relativenumber " Show relative line numbers
set cursorline " Highlight the current line
set hlsearch " Highlight search results
set smartcase " Ignore case when searching for all lowercase
set ignorecase " Ignore case when searching
set autoindent " Copy indent from current line when starting a new line
set smartindent " Insert indents automatically
set hidden " Allow buffers to be hidden
set showmatch " Show matching brackets when text indicator is over them

" tokyonight settings
colorscheme tokyonight-night
highlight ColorColumn ctermbg=256 guibg=blue

" Spell check
set spell spelllang=en_us " Enable spell check
hi clear SpellBad " Remove underline from misspelled words
hi SpellBad term=undercurl cterm=underline gui=undercurl guisp=red

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

" Automatically run prettier on save
autocmd BufWritePre *.js PrettierAsync

" Automatically sources .config/nvim/init.vim after saving it.
autocmd! bufwritepost ~/.config/nvim/init.vim source %

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required for Vundle

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'https://github.com/tpope/vim-fugitive' " vim fugitive for git
Plugin 'itchyny/lightline.vim' " lightline plugin
Plugin 'https://github.com/itchyny/vim-gitbranch.git' " git plugin
Plugin 'scrooloose/nerdtree' " NERDTree plugin
Plugin 'Xuyuanp/nerdtree-git-plugin' " NERDTree Git plugin
Plugin 'keith/swift.vim' " Swift syntax highlighting
Plugin 'leafgarland/typescript-vim' " Typescript syntax highlighting
Plugin 'Yggdroot/indentLine' " plugin for indentation guides
Plugin 'vim-utils/vim-man' " look up man pages without leaving Vim
Plugin 'junegunn/fzf' " binary for fzf
Plugin 'junegunn/fzf.vim' " fuzzy file finder
Plugin 'shmup/vim-sql-syntax' " Better SQL syntax highlighting
Plugin 'drewtempelmeyer/palenight.vim' "palenight colorscheme
Plugin 'arcticicestudio/nord-vim' " nord colorscheme
Plugin 'ryanoasis/vim-devicons' " cool icons for filetypes
Plugin 'w0rp/ale' " Asynchronous Lint Engine
Plugin 'tpope/vim-commentary'
" All Plugins must be added before the following line
call vundle#end()            " required
" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Configuration file for vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'palenight',
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'fugitive', 'filename' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': {
      \   'left': '',
      \   'right': ''
      \ },
      \ 'subseparator': {
      \   'left': '',
      \   'right': ''
      \ }
    \ }

function! LightlineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightlineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? WebDevIconsGetFileTypeSymbol() . ' ' . expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

" ale lint aliases to map one filetype's lint settings to another if we want
let g:ale_linter_aliases = {'typescript': ['typescript', 'javascript']}

" ale fixers to run while creating a file
let b:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['prettier', 'eslint']
    \}

" ale linters to run based on filetype 
let b:ale_linters = {
    \   'python': ['pylint']
    \}

" ale fixers run on file write.
let g:ale_fix_on_save = 1

" always show gutter column, because shifting the text while typing is
" annoying.
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modelines=0         " CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=2         " more powerful backspacing

" Syntax highlighting.
syntax on

" Show line numbers.
set nu

" Turn on auto indenting. 
set autoindent

" Turn on smart indenting.
set smartindent 

" Set indentation to 4 spaces.
set shiftwidth=4

" Set tabs to display as 4 spaces.
set tabstop=4

" Insert spaces rather than a tab character.
set expandtab

" Turn on smart tabbing so that tabs will tab over to the correct tab based on
" where in the code we are.
set smarttab

" Set background to dark for lighter colors in terminal.
set background=dark

" Highlight search results.
set hlsearch

" Highlight search results as they are found, for each character/change made
" to the search until pressing return key.
set incsearch

" ignore case when searching
set ignorecase

" Auto-save when switching buffers.
set autowrite

" SQL highlighting in PHP strings.
let php_sql_query = 1

" set active buffer to bottom one when doing splits.
set splitbelow

" set active buffer to right one when doing vertical splits.
set splitright

" palenight color scheme.
colorscheme palenight

" use the  terminal bg color.
hi Normal guibg=NONE ctermbg=NONE

" don't wrap lines.
set nowrap

set laststatus=2

set noshowmode " don't show mode in statusline, lightline shows it.

set ttimeoutlen=50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto-insert matching angle braces on the same line for html & xml files.
au FileType html,xml inoremap < <><Left>

" Set markdown syntax highlighting for any .md file 
au BufNewFile, BufRead *.md setf markdown

" Turn off showing line numbers for regulat text files
au FileType text setlocal nonu | IndentLinesDisable
" also turn on spellcheck for text files.
au FileType text setlocal spell spelllang=en_us

" Don't wrap text on SQL files, since table insertions tend to be long.
au FileType sql set nowrap


" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open NERDTree window with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" open a fzf search with a ;
map ; :Files<CR>

" Search for visual selection by pressing //.
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" auto-insert matching braces.
inoremap {<CR> {<CR>}<Esc>ko
inoremap { {}<Left>

" auto-insert matching parens.
inoremap ( ()<Left>

" auto-insert matching brackets.
inoremap [ []<Left>

" auto-insert matching single and double quotes.
inoremap " ""<Left>
inoremap ' ''<Left>

" set the width of the NERDTree pane.
let g:NERDTreeWinSize=40

" set apache, html, css, json, typscript, php and sql files to have 2 space tab widths.
au FileType apache,html,css,json,typescript,php,sql set ts=2 sw=2

" set the git diff window to vertical split.
set diffopt+=vertical 

" % matching of HTML tags
runtime macros/matchit.vim

" Ctrl+\ to show word count and stuff.
map <C-\> g<C-g>

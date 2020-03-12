"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if we don't have it already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent !mkdir ~/.vim/swapfiles
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Themes
Plug 'drewtempelmeyer/palenight.vim' "palenight colorscheme
Plug 'arcticicestudio/nord-vim' " nord colorscheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'joshdick/onedark.vim' " onedark colorscheme
Plug 'morhetz/gruvbox'

" Persistent plugins
Plug 'tpope/vim-fugitive' " vim fugitive for git
Plug 'itchyny/lightline.vim' " lightline plugin
Plug 'scrooloose/nerdtree' " NERDTree plugin
Plug 'Xuyuanp/nerdtree-git-plugin' " NERDTree Git plugin
Plug 'Yggdroot/indentLine' " plugin for indentation guides
Plug 'vim-utils/vim-man' " look up man pages without leaving Vim
Plug 'junegunn/fzf' "fzf binary
Plug 'junegunn/fzf.vim' " fuzzy file finder plugin
Plug 'ryanoasis/vim-devicons' " cool icons for filetypes
Plug 'dense-analysis/ale' " Asynchronous Lint Engine
Plug 'tpope/vim-commentary' " Better Vim commenting
Plug 'jiangmiao/auto-pairs' " auto-pairs on braces, quotes, etc.
Plug 'tpope/vim-surround' " easy quoting, parenthesizing, etc.
Plug 'ycm-core/YouCompleteMe' " YouCompleteMe for autocompletion.


" Clojure-specific plugins
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }

Plug 'alvan/vim-closetag' " auto-close html/xml tags.

" Filetype-sensitive plugins
Plug 'ap/vim-css-color', { 'for': [ 'css', 'scss' ] } " CSS color highlighting in Vim
Plug 'shmup/vim-sql-syntax' " Better SQL syntax highlighting
Plug 'sheerun/vim-polyglot' " Multiple language packs for Vim.

" All Plugins must be added before the following line
" To ignore plugin indent changes, instead use:
filetype plugin indent on  " required
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'coc#status', 'fugitive', 'filename' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'filename': 'LightlineFilename',
      \   'modified': 'LightlineModified'
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

"ale fixers to run while creating a file
let g:ale_fixers = {
    \   '*': ['remove_trailing_lines', 'trim_whitespace'],
    \   'javascript': ['prettier', 'eslint'],
    \   'typescript': ['prettier', 'tslint'],
    \   'vue': ['prettier', 'eslint'],
    \   'python': ['add_blank_lines_for_python_control_statements', 'isort', 'yapf']
    \}

let g:ale_linters = { 'vue': ['eslint', 'vls'] }

" ale fixers run on file write.
let g:ale_fix_on_save = 1

" lint when leaving insert mode
let g:ale_lint_on_insert_leave = 1

" always show the ALE gutter, so the window doesn't constantly shift back and
" forth.
let g:ale_sign_column_always = 1

let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}


" custom ALE warning/error message string
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" set the width of the NERDTree pane.
let g:NERDTreeWinSize=40

let g:closetag_filetypes='html,xhtml,jsx,vue,xml'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set updatetime=300
set signcolumn=yes
set hidden

" Indicate more visibly which line the cursor is on.
set cursorline

" SQL highlighting in PHP strings.
let php_sql_query = 1

set modelines=0         " CVE-2007-2438

set cursorline

" set the git diff window to vertical split.
set diffopt+=vertical

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=2         " more powerful backspacing

" Syntax highlighting.
syntax on

" keep lines limited to 80 characters in width.
set textwidth=80

" UTF-8 text encoding.
set encoding=utf-8

set directory=$HOME/.vim/swapfiles//

" Show line numbers.
set nu

" Show relative line numbers too.
set relativenumber

" wildmenu on.
set wildmenu

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

" Italicize comments
highlight Comment gui=italic

" Highlight search results.
set hlsearch

" Highlight search results as they are found, for each character/change made
" to the search until pressing return key.
set incsearch

" ignore case when searching
set ignorecase

" Auto-save when switching buffers.
set autowrite

" set active buffer to bottom one when doing splits.
set splitbelow

" set active buffer to right one when doing vertical splits.
set splitright

" don't wrap lines.
set nowrap

" show statusline.
set laststatus=2

" don't show mode in statusline, lightline shows it.
set noshowmode

" speed up terminal timeout. lightline mode transitions are laggy without it.
set ttimeoutlen=50

" if using GUI (GVIM, MacVim), set the font to Hack.
" otherwise, use the terminal bg color, since colorschemes can sometimes not play
" nice with the terminal emulator.
" Also use different colorschemes between GUI Vim and terminal Vim,
" and use different colorschemes between OSes.

if has('gui_running')
    set guioptions-=T
    set guioptions-=m
    if has('mac')
        set guifont=Hack\ Nerd\ Font
        colorscheme palenight
        let g:lightline.colorscheme = 'palenight'
    elseif has('win32')
        set guifont=Hack:h10
        colorscheme onedark
        let g:lightline.colorscheme = 'onedark'
    else " Linux
        set guifont=Hack
        colorscheme gruvbox
        let g:lightline.colorscheme = 'gruvbox'
        let g:gruvbox_contrast_dark = 'medium'
    endif
else
    " Use gruvbox for terminal Vim.
    colorscheme gruvbox
    let g:lightline.colorscheme = 'gruvbox'
        let g:gruvbox_contrast_dark = 'medium'
    hi Normal ctermbg=NONE
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FILETYPE SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set markdown syntax highlighting for any .md file
au BufNewFile, BufRead *.md setf markdown

" Turn off showing line numbers for regulat text files
au FileType text setlocal nonu | IndentLinesDisable

" also turn on spellcheck for text files.
au FileType text setlocal spell spelllang=en_us

" set apache, html, css, json, typscript, php and sql files to have 2 space tab widths.
au FileType apache,html,css,json,typescript,javascript,php,sql,vue set ts=2 sw=2
au FileType python set ts=4

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

" % matching of HTML tags
runtime macros/matchit.vim

" Ctrl+\ to show word count and stuff.
map <C-\> g<C-g>

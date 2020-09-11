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
Plug 'mhartington/oceanic-next'

" Persistent plugins
Plug 'itchyny/lightline.vim' " lightline plugin
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'} " NERDTree plugin
Plug 'Xuyuanp/nerdtree-git-plugin', {'on': 'NERDTreeToggle'} " NERDTree Git plugin
Plug 'Yggdroot/indentLine' " plugin for indentation guides
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Vim code-completion engine that uses language servers.
Plug 'ervandew/supertab' " tab-completion for coc.nvim
Plug 'vim-utils/vim-man' " look up man pages without leaving Vim
Plug 'junegunn/fzf', {'on': 'Files'} "fzf binary
Plug 'junegunn/fzf.vim', {'on': 'Files'} " fuzzy file finder plugin
Plug 'ryanoasis/vim-devicons' " cool icons for filetypes
Plug 'jiangmiao/auto-pairs' " auto-pairs on braces, quotes, etc.
Plug 'tpope/vim-surround' " easy quoting, parenthesizing, etc.
Plug 'tpope/vim-repeat' " enable repetition of plugin maps with '.'
Plug 'tpope/vim-commentary' " Better Vim commenting
Plug 'tpope/vim-fugitive' " vim fugitive for git
Plug 'sheerun/vim-polyglot' " Multiple language packs for Vim.
Plug 'ludovicchabant/vim-gutentags' " gutentags for tagfile generation
Plug 'voldikss/vim-floaterm' " Floating terminal window

" Ruby-specific plugins
Plug 'tpope/vim-rails', {'for': [ 'ruby', 'eruby' ]} " Ruby on Rails plugin

" Clojure-specific plugins
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }

Plug 'alvan/vim-closetag' " auto-close html/xml tags.

" CSS-specific plugins
Plug 'ap/vim-css-color', { 'for': [ 'css', 'scss' ] } " CSS color highlighting in Vim

" SQL-specific plugins
Plug 'shmup/vim-sql-syntax' " Better SQL syntax highlighting

" All Plugins must be added before the following line
" To ignore plugin indent changes, instead use:
filetype plugin indent on  " required
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_autoclose = 2 " always auto-close floating terminal

let g:gutentags_exclude_project_root = ['/usr/local', '~/.vim']

let g:gutentags_cache_dir = '~/.vim/ctagscache/'

let g:gutentags_project_root = ['node_modules', 'Makefile', 'Gemfile', 'pom.xml']

let g:lightline = {
      \ 'active': {
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'fugitive', 'filename' ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'filetype' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'filename': 'LightlineFilename',
      \   'modified': 'LightlineModified'
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
  let branch = fugitive#head()
  return branch !=# '' ? ' '.branch : ''
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? WebDevIconsGetFileTypeSymbol() . ' ' . expand('%:t') : '[No Name]') .
       \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

" set the width of the NERDTree pane.
let g:NERDTreeWinSize=40

let g:closetag_filetypes='html,xhtml,jsx,vue,xml,javascript,javascriptreact,eruby'

let g:SuperTabDefaultCompletionType = "<C-n>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set updatetime=300
set signcolumn=yes
set hidden

filetype plugin on

" Indicate more visibly which line the cursor is on.
set cursorline

" SQL highlighting in PHP strings.
let php_sql_query = 1

set modelines=0         " CVE-2007-2438

set cursorline

" set the git diff window to vertical split.
set diffopt+=vertical

set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=2         " more powerful backspacing

" Syntax highlighting.
syntax on

" keep lines limited to 80 characters in width.
set textwidth=80

set formatoptions=tcqjron

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

" Set default indentation
set shiftwidth=2

" Set default tabstop.
set tabstop=2

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

" Don't ignore case when using caps.
set smartcase 

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

" speed up terminal timeout. lightline mode transitions can be laggy without it.
set ttimeoutlen=50

" colorscheme settings
colorscheme nord
let g:lightline.colorscheme = 'nord'

if has('gui_running')
    " only set these if a GUI is running.
    set guioptions-=T
    set guioptions-=m
    if has('mac') 
      if !has('nvim')
        set guifont=SauceCodePro\ Nerd\ Font\ Mono:h12 
      endif
    else
      set guifont=SauceCodePro\ Nerd\ Font\ Mono\ 11 
    endif
else
    if !has('mac')
        " don't turn on termguicolors if we're on a Mac; Terminal.app gets wonky
        " with this on.
        set termguicolors
    endif
endif

" Italicize comments
highlight Comment gui=italic

" Set markdown syntax highlighting for any .md file
au BufNewFile, BufRead *.md setf markdown

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup

" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open NERDTree window with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

" open a fzf search with Ctrl+P
map <C-p> :Files<CR>

" Search for visual selection by pressing //.
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" % matching of HTML tags
runtime macros/matchit.vim

" Ctrl+\ to open a terminal. 
map <C-\> :FloatermToggle<CR>

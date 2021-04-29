""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim & nvim shared config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:is_nvim = has('nvim')
let g:is_vim8 = v:version >= 800 ? 1 : 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if we don't have it already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent !mkdir ~/.vim/swapfiles
  autocmd vimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""
" Themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'sonph/onehalf', {'rtp': '.vim/'}
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox' 
Plug 'mhartington/oceanic-next'
Plug 'embark-theme/vim', { 'as': 'embark' }

" Aesthetic customization
Plug 'itchyny/lightline.vim' " lightline plugin
Plug 'Yggdroot/indentLine' " plugin for indentation guides
Plug 'ryanoasis/vim-devicons' " cool icons for filetypes

"""""""""""""""""""""""""
" Functionality
"""""""""""""""""""""""""
" General QOL stuff:
" ------------------
Plug 'neoclide/coc.nvim', {'branch': 'release'} " code-completion via LSP.
Plug 'vim-utils/vim-man' " look up man pages without leaving vim
Plug 'junegunn/fzf', {'do': { -> fzf#install() }} "fzf binary
Plug 'junegunn/fzf.vim' " fuzzy file finder plugin
Plug 'junegunn/gv.vim' " git commit browsing made easy
Plug 'AndrewRadev/tagalong.vim' " auto-update matching HTML tags
Plug 'jiangmiao/auto-pairs' " auto-pairs on braces, quotes, etc.
Plug 'tpope/vim-surround' " easy quoting, parenthesizing, etc.
Plug 'tpope/vim-repeat' " enable repetition of plugin maps with '.'
Plug 'tpope/vim-commentary' " Better Vim commenting
Plug 'tpope/vim-fugitive' " vim fugitive for git
Plug 'sheerun/vim-polyglot' " Multiple syntax highlighting language packs.
Plug 'voldikss/vim-floaterm' " Floating terminal window
Plug 'alvan/vim-closetag' " auto-close html/xml tags.
Plug 'glippi/yarn-vim' " Yarn integration in Vim.
Plug 'kkvh/vim-docker-tools' " Docker integration for Vim.
Plug 'tpope/vim-projectionist'
Plug 'justinmk/vim-sneak' " quick navigation

" Neovim-only plugins:
if g:is_nvim
  " These need Neovim 0.5, which hasn't officially released yet.
  " Plug 'nvim-treesitter/nvim-treesitter' " Better syntax highlighting
endif

" Language/framework-specific:
" ------------------

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' } " Live markdown-rendering preview in the browser

" JSON
Plug 'mogelbrod/vim-jsonpath', { 'for': 'json' } " navigate JSON files via object keys.
Plug 'tpope/vim-jdaddy', { 'for': 'json' } " supports JSON objects as vim text objects

" SQL
Plug 'shmup/vim-sql-syntax' " better SQL syntax highlighting

" CSS/SCSS
Plug 'ap/vim-css-color', { 'for': [ 'css', 'scss' ] } " highlight colors.
Plug 'cakebaker/scss-syntax.vim', { 'for': [ 'css', 'scss' ] } " syntax highlighting for CSS/SCSS

" Ruby/Rails
Plug 'tpope/vim-rails' " rails integration
Plug 'tpope/vim-rvm' " rvm wrapper for vim.
Plug 'tpope/vim-bundler' " ruby bundler integration
Plug 'tpope/vim-rake' " rake integration
Plug 'kana/vim-textobj-user' " dependency for textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' } " add support for Ruby code blocks as vim text objects

" Clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-salve', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }

" Liquid
Plug 'tpope/vim-liquid', { 'for': 'liquid' } " plugin for liquid templates

" All Plugins must be added before the following line
" To ignore plugin indent changes, instead use:
filetype plugin indent on  " required
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:mkdp_open_to_the_world = 1

let g:mkdp_auto_start = 0

let g:floaterm_autoclose = 2 " always auto-close floating terminal

let g:indentLine_char = '│'

let g:lightline = {
  \ 'active': {
    \ 'left': [
      \ [ 'mode', 'paste' ],
      \ [ 'fugitive', 'filename' ]
    \ ],
    \ 'right': [
      \ [ 'lineinfo' ],
      \ [ 'percent' ],
      \ [ 'filetype' ]
    \ ]
  \ },
  \ 'component_function': {
      \ 'fugitive': 'LightlineFugitive',
      \ 'readonly': 'LightlineReadonly',
      \ 'filename': 'LightlineFilename',
      \ 'modified': 'LightlineModified'
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
       \ ('' != expand('%:t') ? WebDevIconsGetFileTypeSymbol() . ' ' . 
       \ expand('%:t') : '[No Name]') . ('' != LightlineModified() ? 
       \ ' ' . LightlineModified() : '')
endfunction

let g:closetag_filetypes='html,xhtml,jsx,xml,javascript,javascriptreact,eruby,liquid'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" don't put anything in the header when printing a hardcopy
set printheader=\  

" set paper type to U.S. Letter
set printoptions=paper:letter

" keep the signcolumn open all the time
set signcolumn=yes

" don't abandon buffers when they're left
set hidden

" enable plugins for specific file types
filetype plugin on

" Enable true color support
set termguicolors

" indicate more visibly which line the cursor is on
set cursorline

" don't show last command
set noshowcmd

" SQL highlighting in PHP strings.
let php_sql_query = 1

" use a vertical split when performing diffs
set diffopt+=vertical

if !g:is_nvim 
  " No backwards compatibility with vi
  set nocompatible
endif

" proper backspacing
set backspace=indent,eol,start

" Syntax highlighting.
syntax on

" generally keep lines limited to 80 characters in width.
set textwidth=80

" nice-to-have formatting options. 'tcqj' is the default, this adds:
" r - auto-insert the comment leader after hitting Enter in insert mode
" o - auto-insert the comment leader after hitting 'o' or 'O' in normal mode
" n - recognize numbered lists
" w - trailing whitespace means a paragraph continues on the next line, while a 
"     line that ends with a non-whitespace character means the paragraph ends.
set formatoptions=tcqjronw

" UTF-8 text encoding.
set encoding=utf-8

" put swapfiles here, so they're all collected in one place and there aren't 
" issues with version control systems.
set directory=$HOME/.vim/swapfiles//

" Show line numbers
set number

" Show relative line numbers too
set relativenumber

" wildmenu on
set wildmenu

" Turn on auto indenting
set autoindent

" Turn on smart indenting
set smartindent

" Set default indentation
set shiftwidth=2

" Set default tabstop
set tabstop=2

" insert appropriate number of spaces for a <Tab> keypress
set expandtab

" Set background to dark
set background=dark

" Highlight search results
set hlsearch

" Highlight search results as they are found, for each character/change made
" to the search until pressing return key
set incsearch

" ignore case when searching
set ignorecase

" Don't ignore case when using caps
set smartcase 

" Auto-save when switching buffers
set autowrite

" set active buffer to bottom one when doing splits
set splitbelow

" set active buffer to right one when doing vertical splits
set splitright

" don't wrap lines
set nowrap

" show statusline
set laststatus=2

" don't show mode in statusline, lightline shows it
set noshowmode

" speed up terminal timeout. lightline mode transitions can be laggy without it.
set ttimeoutlen=50

" Make floating windows slightly transparent
if g:is_nvim
  set winbl=10
endif

" auto-reload a file if change was detected outside of vim
set autoread

" colorscheme settings
try
  colorscheme palenight
  let g:lightline.colorscheme = 'palenight'
catch 
  " if custom colorschemes aren't installed yet, fall back to the built-in slate colorscheme
  colorscheme slate
endtry

if has('gui_running')
  " settings for gVim
  set guioptions-=T
  set guioptions-=m
  try 
    if !(has('nvim') && has('mac'))
      set guifont=MesloLGMDZ\ Nerd\ Font\ Mono:h11
    end
  catch
    echo "Custom font not installed."
  endtry
endif

" Italicize comments
highlight Comment gui=italic cterm=italic

" Don't write backup file if vim is being called by "crontab -e"
augroup CRON
  autocmd BufWrite /private/tmp/crontab.* set nowritebackup nobackup
augroup end

" Don't write backup file if vim is being called by "chpass"
augroup CHPASS
  autocmd BufWrite /private/etc/pw.* set nowritebackup nobackup
augroup end

" Disable indentation guides for man page buffers
augroup MAN_PAGE
  autocmd FileType man IndentLinesDisable
augroup end

augroup JENKINS
  autocmd BufNew,BufEnter *.jenkins set filetype=jenkinsfile
augroup end

if g:is_nvim
  " settings for terminal buffers
  augroup TERM
    autocmd TermOpen * setlocal nonumber norelativenumber 
    autocmd BufEnter term://* startinsert
    autocmd BufLeave term://* stopinsert
  augroup end
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" open explorer window
nnoremap <space>e :CocCommand explorer<CR>

" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
 if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <leader>rn <Plug>(coc-rename)

" If we're in a git repository, only search for files not being ignored.
" Otherwise, fall back to a regular file search.
function! GFilesFallback()
  let output = system('git rev-parse --show-toplevel')
  let prefix = get(g:, 'fzf_command_prefix', '')
  if v:shell_error == 0
    exec "normal :" . prefix . "GFiles\<CR>"
  else
    exec "normal :" . prefix . "Files\<CR>"
  endif
  return 0
endfunction

" open a fzf search with Ctrl+P
nnoremap <C-p> :call GFilesFallback()<CR>

" Search for visual selection by pressing //
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" allows saving of files that weren't open with write permissions.
cmap w!! w !sudo tee %

" % matching of HTML tags
runtime macros/matchit.vim

" Ctrl+\ to open a terminal window.
map <C-\> :FloatermToggle<CR>

" Yank into system clipboard
vnoremap <leader>y "+y
nnoremap <leader>Y "+yg_
nnoremap <leader>yy "+yy

" Paste from system clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
nnoremap <leader>P "+P

" close all buffers without exiting
command! Close bufdo bd
nnoremap <leader>c :Close<CR>

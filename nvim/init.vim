let g:is_mac = has('mac')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug if we don't have it already
if empty(glob("$HOME/.config/nvim/autoload/plug.vim"))
  silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  silent !mkdir $HOME/.config/nvim/swapfiles
  autocmd vimEnter * PlugInstall --sync | source $MYVIMRC
  autocmd vimEnter * CocInstall coc-explorer
endif

call plug#begin('$HOME/.config/nvim/plugged')

"""""""""""""""""""""""""
" Styling
"""""""""""""""""""""""""
" Themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'arcticicestudio/nord-vim'
Plug 'marko-cerovac/material.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'bluz71/vim-nightfly-guicolors'

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
Plug 'tpope/vim-dispatch' " asynchronous build and test dispatching
Plug 'AndrewRadev/splitjoin.vim' " easily convert between single & multi line statements.
Plug 'vim-autoformat/vim-autoformat' " automatically format files using the appropriate tool
Plug 'mogelbrod/vim-jsonpath', { 'for': 'json' } " navigate JSON files via object keys.
Plug 'tpope/vim-jdaddy', { 'for': 'json' } " supports JSON objects as vim text objects
Plug 'lukas-reineke/indent-blankline.nvim' " indent guides
Plug 'airblade/vim-gitgutter'
Plug 'akinsho/toggleterm.nvim'

" neovim-only stuff
" ------------------
Plug 'neovim/nvim-lspconfig' " LSP config plugin
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' } " Better syntax highlighting
Plug 'SmiteshP/nvim-gps'
Plug 'ray-x/lsp_signature.nvim' " LSP-driven code completion helper
Plug 'nanotee/sqls.nvim' " SQL client and query execution plugin
Plug 'norcalli/nvim-colorizer.lua' " Performant color code highlighting
Plug 'folke/lsp-colors.nvim'
Plug 'nvim-lualine/lualine.nvim' " status line
Plug 'kyazdani42/nvim-web-devicons' " icons for filetypes

" Language/framework-specific:
" ------------------
" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': 'markdown' } " Live markdown-rendering preview in the browser

" SQL
Plug 'shmup/vim-sql-syntax' " better SQL syntax highlighting

" CSS/SCSS
Plug 'cakebaker/scss-syntax.vim', { 'for': [ 'css', 'scss' ] } " syntax highlighting for CSS/SCSS

" Ruby/Rails
Plug 'tpope/vim-rails', { 'for': 'ruby' } " rails integration
Plug 'tpope/vim-rvm', { 'for': 'ruby' } " rvm wrapper for vim.
Plug 'tpope/vim-bundler', { 'for': 'ruby' } " ruby bundler integration
Plug 'tpope/vim-rake', { 'for': 'ruby' } " rake integration
Plug 'kana/vim-textobj-user', { 'for': [ 'ruby' ] } " dependency for textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' } " add support for Ruby code blocks as vim text objects
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' } " RSpec integration

" Liquid
Plug 'tpope/vim-liquid', { 'for': 'liquid' } " plugin for liquid templates

" All Plugins must be added before the following line
" To ignore plugin indent changes, instead use:
filetype plugin indent on  " required
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua <<EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local gps = require('nvim-gps')
gps.setup()

local function interpreter_version()
  local str = vim.fn['rvm#statusline_ft_ruby']()
  return str.match(str, '%[ruby%-(%d+.%d+.%d+)%]')
end

local function gps_with_filename()
  local str = vim.fn.expand("%:t")

  if (gps.is_available())
  then
    local gps_location = gps.get_location()
    if (gps_location:gsub("%s+","") == "")
      then
      return str
    end
    str = str .. ' > ' .. gps.get_location()
  end

  if (str:len() == 0)
    then
    return '[No Name]'
  end

  return str
end

require('lualine').setup ({
  options = {
    theme = 'nightfly',
    component_separators = '',
    section_separators = { left = '', right = '' },
    },
  sections = {
    lualine_c = { 
      { gps_with_filename }
    },
    lualine_x = {
      'filetype', interpreter_version 
    }
  }
})

vim.opt.list = true
require('indent_blankline').setup {
  space_char_blankline = " ",
  show_current_context = true,
  show_current_context_start = true
}

require('material').setup({
	contrast = {
    floating_windows = false,
    popup_menu = false
  }, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
	italics = {
		comments = true, -- Enable italic comments
	},
	contrast_filetypes = { -- Specify which windows get the contrasted (darker) background
		"qf" -- Darker qf list background
	},
	disable = {
		background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},
	custom_highlights = {} -- Overwrite highlights with your own
})

function _G.setup_toggle_term()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end

function _G.setup_term()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<C-\\>', [[<C-\><C-n>:FloatermToggle<CR>]], opts)
  vim.api.nvim_win_set_option(0, 'number', false)
  vim.api.nvim_win_set_option(0, 'relativenumber', false)
end

vim.cmd('autocmd! TermOpen term://*toggleterm* lua setup_toggle_term()')
vim.cmd('autocmd! TermOpen term://*zsh* lua setup_term()')
EOF

let g:python3_host_prog = system("which python3")

let g:mkdp_open_to_the_world = 1

let g:mkdp_auto_start = 1

let g:floaterm_autoclose = 2 " always auto-close floating terminal

let g:closetag_filetypes='html,xhtml,jsx,xml,javascript,javascriptreact,eruby,liquid'

if g:is_mac
  let g:rspec_runner = 'os_x_iterm2'
end

let g:rspec_command = "Dispatch rspec {spec}"

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

" proper backspacing
set backspace=indent,eol,start

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

" don't show mode in statusline, lualine shows it
set noshowmode

set winbl=15

" auto-reload a file if change was detected outside of vim
set autoread

" colorscheme settings
try
  " let g:material_style = 'palenight'
  colorscheme nightfly
catch 
  " if custom colorschemes aren't installed yet, fall back to the built-in slate colorscheme
  colorscheme slate
  echo "colorscheme not found"
endtry

" settings for gui-based editor
set guioptions-=T
set guioptions-=m
try 
  if (g:is_mac)
    set guifont=MesloLGMDZ\ Nerd\ Font\ Mono:h11
  end
catch
  echo "Custom font not installed."
endtry

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

augroup JENKINS
  autocmd BufNew,BufEnter *.jenkins set filetype=jenkinsfile
augroup end

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map leader key to <Space>
let mapleader = " "

" open explorer window
nnoremap <leader>e :CocCommand explorer<CR>

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
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

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

" vim-rspec mappings
map <Leader>sf :call RunCurrentSpecFile()<CR>
map <Leader>sn :call RunNearestSpec()<CR>
map <Leader>sl :call RunLastSpec()<CR>
map <Leader>sa :call RunAllSpecs()<CR>

" search within project
nnoremap <leader>f :Rg<CR>

" Git shortcuts
nnoremap <leader>gi :Git<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gP :Git push<CR>
nnoremap <leader>gc :Git commit -m ""<left>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gA :Git add -A<CR>
nnoremap <leader>ggn :GitGutterNextHunk<CR>
nnoremap <leader>ggp :GitGutterPrevHunk<CR>
nnoremap <leader>ggP :GitGutterPreviewHunk<CR>

" DockerTools shortcut
nnoremap <leader>dt :DockerToolsToggle<CR>

" ToggleTerm shortcuts
nnoremap <leader>t :ToggleTerm<CR>

local vim = vim
local fn = vim.fn
local cmd = vim.cmd

local ensure_packer = function()
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    cmd [[packadd packer.nvim]]
    return true
  end
  return false
end


local packer_bootstrap = ensure_packer()
return require('packer').startup(function(use)
  -- packer can manage itself
  use { 'wbthomason/packer.nvim' }

  ------------------------------------------------------------------------------
  -- themes
  ------------------------------------------------------------------------------
  use 'folke/tokyonight.nvim'
  use 'sainnhe/everforest'
  use 'bluz71/vim-nightfly-colors'
  use 'embark-theme/vim'
  use { "catppuccin/nvim", as = "catppuccin" }

  ------------------------------------------------------------------------------
  -- whimsical stuff
  ------------------------------------------------------------------------------
  use 'eandrju/cellular-automaton.nvim'

  ------------------------------------------------------------------------------
  -- general quality of life stuff
  ------------------------------------------------------------------------------

  -- seamless nav between vim & tmux panes
  use {
    'christoomey/vim-tmux-navigator',
    config = function() require 'configs.vim-tmux-navigator' end
  }

  -- load plugins quickfast
  use 'lewis6991/impatient.nvim'

  use {
    'rmagatti/auto-session',
    config = function() require 'configs.auto-session' end,
  }

  -- look up man pages without leaving vim
  use 'vim-utils/vim-man'

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    config = function() require 'configs.lualine' end,
  }

  -- auto-pairs on braces, quotes, etc.
  use {
    'windwp/nvim-autopairs',
    config = function() require 'configs.autopairs' end,
  }
  -- work with different variants of a word
  -- (plural, singular, tableize, capitalize, etc.)
  use {
    'tpope/vim-abolish'
  }

  -- easy quoting, parenthesizing, etc.
  use 'tpope/vim-surround'

  -- enable repetition of plugin maps with '.'
  use 'tpope/vim-repeat'

  -- better vim commenting
  use 'tpope/vim-commentary'

  -- illuminate other instances of a symbol/word
  use {
    'RRethy/vim-illuminate',
    config = function() require 'configs.illuminate' end,
  }

  -- better syntax highlighting and formatting via treesitter
  use {
    requires = {
      'windwp/nvim-ts-autotag',                  -- auto-close html/xml/jsx tags.
      'RRethy/nvim-treesitter-endwise',          -- wisely add `end` to code blocks in languages that use that keyword.
      'nvim-treesitter/nvim-treesitter-context', -- show context within files
      'yioneko/nvim-yati'
    },
    'nvim-treesitter/nvim-treesitter',
    config = function() require 'configs.treesitter' end,
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- easy project management from within vim
  use 'tpope/vim-projectionist'

  -- db stuff
  use {
    'kristijanhusak/vim-dadbod-ui',
    requires = { 'tpope/vim-dadbod' },
  }

  -- wrappers to common unix file commands
  use 'tpope/vim-eunuch'

  -- dotenv stuff for vim
  use 'tpope/vim-dotenv'

  -- asynchronous build and test dispatching
  use 'tpope/vim-dispatch'

  -- easily convert between single & multi line statements.
  use 'AndrewRadev/splitjoin.vim'

  -- indent guides
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require 'configs.indent-blankline' end,
  }

  -- maximize window splits
  use 'szw/vim-maximizer'

  -- easily move function args left and right
  use 'AndrewRadev/sideways.vim'

  -- more powerful <c-a> & <c-x>
  use { 'nat-418/boole.nvim', config = function()
    require 'configs.boole'
  end
  }

  use {
    'norcalli/nvim-colorizer.lua', -- performant color code highlighting
    config = function() require 'configs.colorizer' end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require 'configs.nvim-tree' end
  }

  ------------------------------------------------------------------------------
  -- nvim-telescope & related
  ------------------------------------------------------------------------------

  -- find stuff
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function() require 'configs.telescope' end,
  }

  -- use fzf for telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  }

  -- jump between alternate/related files (e.g. from implementation to spec)
  -- quickly
  use {
    'otavioschwanck/telescope-alternate.nvim',
    config = function() require 'configs.telescope-alternate' end,
  }

  ------------------------------------------------------------------------------
  -- git stuff
  ------------------------------------------------------------------------------

  -- fugitive for git
  use 'tpope/vim-fugitive'

  -- git commit browsing made easy
  use 'junegunn/gv.vim'

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require 'configs.gitsigns' end
  }

  ------------------------------------------------------------------------------
  -- filetype/language specific
  ------------------------------------------------------------------------------

  --------------------------------------
  -- markdown
  --------------------------------------
  -- fire up live previews of markdown files
  use {
    'iamcco/markdown-preview.nvim',
    run = function() fn['mkdp#util#install']() end,
    ft = 'markdown'
  }

  --------------------------------------
  -- ruby/rails
  --------------------------------------
  -- ruby language files for vim
  use {
    'vim-ruby/vim-ruby',
    ft = 'ruby'
  }

  -- rvm wrapper for vim.
  use {
    'tpope/vim-rvm',
    ft = 'ruby'
  }

  -- rails integration
  use {
    'tpope/vim-rails',
    ft = 'ruby',
  }

  -- ruby bundler integration
  use {
    'tpope/vim-bundler',
    ft = 'ruby',
  }

  -- rake integration
  use {
    'tpope/vim-rake',
    ft = 'ruby',
  }

  -- add support for ruby code blocks as vim text objects
  use {
    'nelstrom/vim-textobj-rubyblock',
    requires = {
      'kana/vim-textobj-user',
    },
    ft = 'ruby',
  }

  use {
    'thoughtbot/vim-rspec',
    config = function() require 'configs.vim-rspec' end,
    ft = 'ruby',
  }

  --------------------------------------
  -- liquid
  --------------------------------------
  -- syntax for liquid templates
  use {
    'tpope/vim-liquid',
    ft = 'liquid',
  }

  --------------------------------------
  -- helm charts
  --------------------------------------
  -- syntax highlighting for helm charts
  use {
    'towolf/vim-helm',
    ft = 'helm'
  }

  --------------------------------------
  -- json
  --------------------------------------
  -- navigate json files via object keys.
  use {
    'mogelbrod/vim-jsonpath',
    ft = 'json',
  }

  -- supports json objects as vim text objects
  use {
    'tpope/vim-jdaddy',
    ft = 'json',
  }

  --------------------------------------
  -- csv
  --------------------------------------
  -- csv syntax highlighting
  use {
    'cameron-wags/rainbow_csv.nvim',
    config = function() require 'rainbow_csv'.setup() end,
  }

  ------------------------------------------------------------------------------
  -- lsp stuff
  ------------------------------------------------------------------------------
  -- lsp-driven code completion helper
  use {
    'ray-x/lsp_signature.nvim',
    config = function() require 'configs.lsp-signature' end
  }

  use {
    'zbirenbaum/neodim',
    event = 'LspAttach',
    config = function() require 'neodim'.setup() end,
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer'
    },
    config = function() require 'configs.nvim-cmp' end
  }

  use {
    'lukas-reineke/lsp-format.nvim'
  }

  use {
    'neovim/nvim-lspconfig',
    requires = 'lukas-reineke/lsp-format.nvim',
    config = function() require 'configs.lsp-config' end
  }

  use { 'folke/trouble.nvim', config = function() require 'configs.trouble' end }
  -- use { 'folke/todo-comments.nvim', config = function() require 'configs.todo-comments' end }

  -- helpful lsp stuff for neovim & lua
  use 'folke/neodev.nvim'

  ------------------------------------------------------------------------------
  -- test/spec plugins
  ------------------------------------------------------------------------------
  -- neotest is an integrated test viewer/executer with hooks into lsp stuff
  -- also language agnostic so can add handlers for other languages/frameworks
  -- TODO: un-comment this at some point when neotest works for debugging
  -- Ruby/Rails code
  -- use {
  --   'nvim-neotest/neotest',
  --   requires = {
  --     'antoinemadec/FixCursorHold.nvim',
  --     'nvim-neotest/neotest-plenary',
  --     'olimorris/neotest-rspec',
  --   },
  --   config = function() require 'configs.neotest' end
  -- }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

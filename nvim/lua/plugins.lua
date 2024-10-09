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
  -- work-specific stuff
  ------------------------------------------------------------------------------
  local work_ok, work = pcall(require, 'work')
  if work_ok then work.setup_work_plugins(use) end

  ------------------------------------------------------------------------------
  -- themes
  ------------------------------------------------------------------------------
  use 'bluz71/vim-nightfly-colors'
  use 'comfysage/evergarden'
  use {
    'ellisonleao/gruvbox.nvim',
    config = function() require("gruvbox").setup({ contrast = "soft" }) end
  }
  use 'embark-theme/vim'
  use 'folke/tokyonight.nvim'
  use 'pauchiner/pastelnight.nvim'
  use 'sainnhe/everforest'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'tiagovla/tokyodark.nvim'
  use 'Everblush/nvim'
  use {
    'zenbones-theme/zenbones.nvim',
    requires = 'rktjmp/lush.nvim'
  }
  use 'xero/miasma.nvim'
  use 'diegoulloao/neofusion.nvim'
  use 'rose-pine/neovim'

  ------------------------------------------------------------------------------
  -- whimsical stuff
  ------------------------------------------------------------------------------
  use 'eandrju/cellular-automaton.nvim'

  ------------------------------------------------------------------------------
  -- for writing
  ------------------------------------------------------------------------------
  -- zen mode to block out the distractions
  use 'folke/zen-mode.nvim'

  ------------------------------------------------------------------------------
  -- general quality of life stuff
  ------------------------------------------------------------------------------

  --------------------------------------
  -- movement/motions/keymaps plugins
  --------------------------------------
  -- easy quoting, parenthesizing, etc.
  use {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup() end
  }

  -- enable repetition of plugin maps with '.'
  use 'tpope/vim-repeat'

  -- easily convert between single & multi line statements.
  use 'AndrewRadev/splitjoin.vim'

  -- easily move function args left and right
  use 'AndrewRadev/sideways.vim'

  -- more powerful <c-a> & <c-x> for incrementing/decrementing/toggling values
  use {
    'nat-418/boole.nvim',
    config = function() require 'configs.boole' end
  }

  -- use tab to move cursor out of enclosing braces, brackets, etc
  use {
    'abecodes/tabout.nvim',
    wants = { 'nvim-treesitter' },
    after = { 'nvim-cmp' },
    config = function() require('tabout').setup() end
  }

  -- -- easily fold code blocks
  -- use {
  --   'chrisgrieser/nvim-origami',
  --   config = function() require('origami').setup({}) end
  -- }

  -- seamless nav between vim & tmux panes
  use {
    'christoomey/vim-tmux-navigator',
    config = function() require 'configs.vim-tmux-navigator' end
  }

  --------------------------------------
  -- vim ui stuff
  --------------------------------------
  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'linrongbin16/lsp-progress.nvim' },
    config = function() require 'configs.lualine' end,
  }

  -- highlight other instances of a symbol/word
  use {
    'RRethy/vim-illuminate',
    config = function() require 'configs.illuminate' end,
  }

  -- better syntax highlighting and formatting via treesitter
  use {
    requires = {
      'RRethy/nvim-treesitter-endwise',          -- wisely add `end` to code blocks in languages that use that keyword.
      'nvim-treesitter/nvim-treesitter-context', -- show code context
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

  -- use {
  --   'm-demare/hlargs.nvim',
  --   config = function() require('hlargs').setup() end
  -- }

  -- auto-close html/xml/jsx tags.
  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
    config = function() require 'configs.autotag' end,
  }
  -- indent guides
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function() require 'configs.indent-blankline' end,
  }

  -- performant color code highlighting
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require 'configs.colorizer' end
  }

  -- file explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() require 'configs.nvim-tree' end
  }

  -- asynchronous build and test dispatching
  use 'tpope/vim-dispatch'

  -- manage docker stuff from vim
  use 'kkvh/vim-docker-tools'

  -- scrollbars with decoration (git, LSP diagnostics, etc.)
  use {
    'lewis6991/satellite.nvim',
    config = function()
      require('satellite').setup()
    end
  }

  --------------------------------------
  -- everything else
  --------------------------------------
  -- persisted sessions
  -- use {
  --   'olimorris/persisted.nvim',
  --   config = function() require 'configs.persisted' end
  -- }

  -- tmux command integration
  use 'tpope/vim-tbone'

  -- load plugins quickfast
  use 'lewis6991/impatient.nvim'

  -- look up man pages without leaving vim
  use 'vim-utils/vim-man'

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

  -- easy project management from within vim
  use 'tpope/vim-projectionist'

  -- db ui for vim
  use {
    'kristijanhusak/vim-dadbod-ui',
    requires = { 'tpope/vim-dadbod' },
  }

  -- wrappers to common unix file commands
  use 'tpope/vim-eunuch'

  -- dotenv stuff for vim
  use 'tpope/vim-dotenv'

  ------------------------------------------------------------------------------
  -- ai stuff
  ------------------------------------------------------------------------------
  use {
    "jackMort/ChatGPT.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function() require("chatgpt").setup() end
  }

  ------------------------------------------------------------------------------
  -- nvim-telescope & related
  ------------------------------------------------------------------------------

  -- use fzf for telescope
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  -- find stuff
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function() require 'configs.telescope' end,
  }

  -- jump between alternate/related files (e.g. from implementation to spec)
  -- quickly
  -- use {
  --   'otavioschwanck/telescope-alternate.nvim',
  --   config = function() require 'configs.telescope-alternate' end,
  -- }

  use {
    'rgroli/other.nvim',
    config = function() require('other-nvim').setup({ mappings = { 'rails' }, rememberBuffers = false }) end
  }

  -- personal wiki
  use {
    'serenevoid/kiwi.nvim',
    config = function() require 'configs.kiwi' end,
    requires = { { 'nvim-lua/plenary.nvim' } }
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
  -- rvm wrapper for vim.
  use {
    'tpope/vim-rvm',
    ft = 'ruby'
  }

  -- rails integration
  use 'tpope/vim-rails'

  -- Bundler integration
  use 'tpope/vim-bundler'

  -- uses Dispatch to run tests asynchronously
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

  --------------------------------------
  -- kitty
  --------------------------------------
  -- kitty config file syntax highlighting
  use "fladson/vim-kitty"


  --------------------------------------
  -- debugging
  --------------------------------------
  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"
    }, config = function()
    require 'configs.dap'
  end
  }
  -- use {
  --   'mfussenegger/nvim-dap',
  --   config = function()
  --     require 'configs.dap'
  --   end
  -- }

  ------------------------------------------------------------------------------
  -- lsp stuff
  ------------------------------------------------------------------------------
  -- snippets for common patterns in various languages
  use 'rafamadriz/friendly-snippets'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
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
    'neovim/nvim-lspconfig',
    requires = {
      'lukas-reineke/lsp-format.nvim',
    },
    config = function()
      require 'configs.lspconfig'
    end
  }

  use { 'folke/trouble.nvim', config = function() require 'configs.trouble' end }

  -- helpful lsp stuff for neovim & lua
  use 'folke/neodev.nvim'

  -- vs-code-style ui to view references/definitions
  use {
    'dnlhc/glance.nvim',
    config = function() require 'configs.glance' end
  }

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

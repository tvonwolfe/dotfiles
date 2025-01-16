return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function()
        require('telescope').load_extension('fzf')
      end,
    },
    {
      'nvim-telescope/telescope-dap.nvim',
      config = function()
        require('telescope').load_extension('dap')
      end
    }
  },
  config = function()
    local telescope = require('telescope')

    telescope.setup({
      defaults = {
        winblend = 15
      },
      pickers = {
        find_files = {
          hidden = true,
          theme = 'dropdown'
        },
        buffers = {
          theme = 'dropdown'
        },
        lsp_document_symbols = {
          sorting_strategy = 'ascending'
        },
        colorscheme = {
          theme = 'dropdown'
        },
      },
      extensions = {
        fzf = {
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        }
      },
      file_ignore_patterns = {
        ".git/",
      }
    })
  end,
  keys = {
    {
      '<leader>ff',
      function()
        require('telescope.builtin').find_files()
      end,
      { desc = 'List and search files by filename' },
    },
    {
      '<leader>fg',
      function()
        require('telescope.builtin').live_grep()
      end,
      { desc = 'Grep files in workspace' },
    },
    {
      '<leader>fb',
      function()
        require('telescope.builtin').buffers()
      end,
      { desc = 'List and search open buffers' },
    },
    {
      '<leader>fh',
      function()
        require('telescope.builtin').help_tags()
      end,
      { desc = 'List & search helptags' },
    },
    {
      '<leader>fm',
      function()
        require('telescope.builtin').man_pages()
      end,
      { desc = 'List & search man pages' },
    },
    {
      '<leader>bh',
      function()
        require('telescope.builtin').git_bcommits()
      end,
      { desc = 'List & search git commits for current buffer' },
    },
  }
}

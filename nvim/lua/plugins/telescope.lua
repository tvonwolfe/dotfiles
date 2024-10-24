local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then return end

telescope.setup {
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
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = 'smart_case',
    }
  },
  file_ignore_patterns = {
    ".git/",
  }
}

telescope.load_extension('fzf')
telescope.load_extension('dap')
-- telescope.load_extension('telescope-alternate')
-- telescope.load_extension('persisted')

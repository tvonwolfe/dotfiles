return {
  'kyazdani42/nvim-tree.lua',
  dependencies = {
    'kyazdani42/nvim-web-devicons',
  },
  keys = {
    { '<leader>t', '<cmd>NvimTreeToggle<CR>', desc = 'Toggle Nvim Tree' },
  },
  lazy = true,
  opts = {
    view = {
      adaptive_size = true
    },
    actions = {
      change_dir = {
        enable = false,
      },
    },
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    }
  }
}

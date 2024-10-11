local nvim_tree = require 'nvim-tree'
nvim_tree.setup {
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

return {
  'folke/trouble.nvim',
  opts = {},
  cmd = { "Trouble" },
  keys = {
    {
      '<leader>xx',
      '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
      desc = 'toggle diagnostics window',
    }
  },
}

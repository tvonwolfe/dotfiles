return {
  'Wansmer/sibling-swap.nvim',
  dependencies = { 'nvim-treesitter' },
  config = function() require('sibling-swap').setup() end,
  keys = {
    { '<leader>h', function() require('sibling-swap').swap_with_left() end,  { desc = 'move TS node to the left' } },
    { '<leader>l', function() require('sibling-swap').swap_with_right() end, { desc = 'move TS node to the right' } },
  }
}

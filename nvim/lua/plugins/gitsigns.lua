return {
  'lewis6991/gitsigns.nvim',
  opts = {},
  keys = {
    { '[g', function() require('gitsigns').nav_hunk('prev') end, { desc = 'Jump to previous git change hunk' } },
    { ']g', function() require('gitsigns').nav_hunk('next') end, { desc = 'Jump to next git change hunk' } }
  }
}

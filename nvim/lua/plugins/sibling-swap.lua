return {
    'Wansmer/sibling-swap.nvim',
    opts = { use_default_keymaps = false },
    keys = {
        { '<C-}>', function() require('sibling-swap').swap_with_right() end, { desc = 'move TS node to the right' } },
        { '<C-{>', function() require('sibling-swap').swap_with_left() end,  { desc = 'move TS node to the left' } }
    }
}

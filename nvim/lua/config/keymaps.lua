vim.g.mapleader = ' '

-- search for other instances of visual selection
vim.keymap.set('v', '//', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>",
  { desc = 'Search for other instances of visual selection' })

vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy selected text to system clipboard' })
-- vim.keymap.set('n', '<leader>Y', '+yg_', { desc = 'Copy ' }) -- doesn't work
vim.keymap.set('n', '<leader>Yy', '"+yy', { desc = 'Copy current line to system clipboard' })

-- paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste from system clipboard above current line' })

vim.keymap.set('t', '<esc>', [[<C-\><C-n>]],
  { desc = 'Enable pressing <esc> to exit insert mode in a terminal buffer' })

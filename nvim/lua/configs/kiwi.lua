local keymap = vim.keymap
local kiwi_ok, kiwi = pcall(require, 'kiwi')

if not kiwi_ok then return end

kiwi.setup()

keymap.set('n', '<leader>ww', kiwi.open_wiki_index)
-- TODO: figure out why these functions are `nil`
-- keymap.set('n', '<leader>wd', kiwi.open_diary_index)
-- keymap.set('n', '<leader>wn', kiwi.open_diary_new)
keymap.set('n', '<leader>wt', kiwi.todo.toggle)

-- Turn on spellcheck for named buffers only.
if vim.fn.expand('%') ~= '' then
  vim.opt_local.spell = true
  vim.opt_local.spelllang = { "en_us" }
end

vim.cmd [[ IlluminatePauseBuf ]]

vim.opt_local.textwidth = 0
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.signcolumn = 'no'
vim.opt_local.number = false
vim.opt_local.relativenumber = false

vim.keymap.set("n", "j", "gj", { buffer = true })
vim.keymap.set("n", "k", "gk", { buffer = true })
vim.keymap.set("n", "0", "g0", { buffer = true })
vim.keymap.set("n", "$", "g$", { buffer = true })

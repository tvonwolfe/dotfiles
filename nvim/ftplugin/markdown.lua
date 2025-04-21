-- Turn on spellcheck for named buffers only.
if vim.fn.expand('%') ~= '' then
  vim.cmd [[setlocal spell spelllang=en_us]]
end

-- re-format upon exiting insert mode.
vim.cmd [[setlocal formatoptions+=a]]
vim.cmd [[setlocal conceallevel=0]]

vim.cmd "IlluminatePauseBuf"

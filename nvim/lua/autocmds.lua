local vim = vim
vim.cmd('autocmd! TermOpen * set nonumber norelativenumber nocursorline|startinsert')

vim.cmd('autocmd! BufWritePre * :%s/\\s\\+$//e')
vim.cmd [[cabbrev wq execute "lua vim.lsp.buf.format()" <bar> wq]]

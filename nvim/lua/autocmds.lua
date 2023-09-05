local cmd = vim.cmd

cmd 'autocmd! TermOpen * set nonumber norelativenumber nocursorline|startinsert'

cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

cmd 'autocmd! VimResized * wincmd ='

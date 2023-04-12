local cmd = vim.cmd

cmd 'autocmd! TermOpen * set nonumber norelativenumber nocursorline|startinsert'

cmd [[cabbrev wq execute "lua vim.lsp.buf.format()" <bar> wq]]

cmd 'autocmd! VimResized * wincmd ='

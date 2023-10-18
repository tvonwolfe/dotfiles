local cmd = vim.cmd

-- make terminal windows look like a normal terminal, not a buffer
cmd 'autocmd! TermOpen * set nonumber norelativenumber nocursorline|startinsert'

-- auto-close terminal windows on shell exit
cmd "autocmd! TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif"

-- format files on save if there's an lsp attached
cmd [[autocmd! BufWritePre * lua vim.lsp.buf.format()]]

-- lint files on save
cmd [[autocmd! BufWritePost * lua require('lint').try_lint()]]

-- keep windows sized equally as vim is resized
cmd 'autocmd! VimResized * wincmd ='

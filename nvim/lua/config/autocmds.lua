local cmd = vim.cmd

-- make terminal windows look like a normal terminal, not a buffer
cmd 'autocmd! TermOpen * setlocal nonumber norelativenumber nocursorline|startinsert'

-- keep windows sized equally as vim is resized
cmd 'autocmd! VimResized * wincmd ='

-- format files on save if there's an lsp attached
-- TODO: refactor so autocmd is created for buffers with LSPs attached
-- (on_attach callback)
cmd [[autocmd! BufWritePre * lua vim.lsp.buf.format()]]

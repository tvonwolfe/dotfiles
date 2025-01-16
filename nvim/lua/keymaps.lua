MODES = {
  normal = 'n',
  insert = 'i',
  visual = 'v',
  terminal = 't',
}

local cmd = vim.cmd

local function map(mode, shortcut, command, opts)
  opts = vim.tbl_extend('force', { noremap = true, silent = true }, opts or {})
  vim.keymap.set(mode, shortcut, command, opts)
end

local function nmap(shortcut, command, opts)
  map(MODES.normal, shortcut, command, opts)
end

local function vmap(shortcut, command, opts)
  map(MODES.visual, shortcut, command, opts)
end

local function tmap(shortcut, command, opts)
  map(MODES.terminal, shortcut, command, opts)
end

local setup = function()
  cmd('noremap <C-b> :noh<CR>:call clearmatches()<CR>')

  vim.g.mapleader = ' '

  -- search for other instances of visual selection
  vmap('//', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>", { desc = 'Search for other instances of visual selection' })

  vmap('<leader>y', '"+y', { desc = 'Copy selected text to system clipboard' })
  -- nmap('<leader>Y', '+yg_', { desc = 'Copy ' }) -- doesn't work
  nmap('<leader>Yy', '"+yy', { desc = 'Copy current line to system clipboard' })

  -- paste from clipboard
  nmap('<leader>p', '"+p', { desc = 'Paste from system clipboard' })
  nmap('<leader>P', '"+P', { desc = 'Paste from system clipboard above current line' })

  -- vim-fugitive
  nmap('<leader>gp', '<cmd>Git pull<CR>', { desc = 'Pull git branch from remote' })
  nmap('<leader>gP', '<cmd>Git push<CR>', { desc = 'Push git branch to remote' })
  nmap('<leader>ga', '<cmd>Git add %<CR>', { desc = 'Stage current file' })
  nmap('<leader>gc', '<cmd>Git commit<CR>', { desc = 'Commit staged files in git' })

  tmap('<esc>', [[<C-\><C-n>]], { desc = 'Enable pressing <esc> to exit insert mode in a terminal buffer' })
end

return {
  setup = setup,
  nmap = nmap,
  vmap = vmap,
  tmap = tmap,
}

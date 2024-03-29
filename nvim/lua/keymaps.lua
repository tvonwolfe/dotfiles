MODES = {
  normal = 'n',
  insert = 'i',
  visual = 'v',
  terminal = 't',
}

local fn = vim.fn
local cmd = vim.cmd

-- local neotest = require('neotest')

local function map(mode, shortcut, command, bufopts)
  bufopts = bufopts or { remap = false, silent = true }
  vim.keymap.set(mode, shortcut, command, bufopts)
end

local function nmap(shortcut, command, bufopts)
  map(MODES.normal, shortcut, command, bufopts)
end

local function vmap(shortcut, command, bufopts)
  map(MODES.visual, shortcut, command, bufopts)
end

local function tmap(shortcut, command, bufopts)
  map(MODES.terminal, shortcut, command, bufopts)
end

cmd('noremap <C-b> :noh<CR>:call clearmatches()<CR>')

vim.g.mapleader = ' '

-- search for other instances of visual selection
vmap('//', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

vmap('<leader>y', '"+y')
nmap('<leader>Y', '+yg_')
nmap('<leader>Yy', '"+yy')

-- paste from clipboard
nmap('<leader>p', '"+p')
nmap('<leader>P', '"+P')
vmap('<leader>p', '"+p')

-- vim-fugitive
nmap('<leader>gp', '<cmd>Git pull<CR>')
nmap('<leader>gP', '<cmd>Git push<CR>')
nmap('<leader>ga', '<cmd>Git add %<CR>')
nmap('<leader>gc', '<cmd>Git commit<CR>')

-- maximize the current buffer
nmap('<C-w>m', '<cmd>MaximizerToggle<CR>')

-- sideways.vim
nmap('<C-n>', '<cmd>SidewaysLeft<CR>')
nmap('<C-m>', '<cmd>SidewaysRight<CR>')

nmap('<leader>fu', '<cmd>CellularAutomaton make_it_rain<CR>')

-- docker tools
nmap('<leader>dt', '<cmd>DockerToolsToggle<CR>')

-- jump between git change hunks
local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')

if gitsigns_ok then
  nmap('[g', gitsigns.prev_hunk)
  nmap(']g', gitsigns.next_hunk)
end

-- Telescope & Glance
local telescope_builtins_ok, telescope_builtins = pcall(require, 'telescope.builtin')
local glance_ok, glance = pcall(require, 'glance')

if telescope_builtins_ok then
  nmap('<leader>ff', telescope_builtins.find_files)
  nmap('<leader>fg', telescope_builtins.live_grep)
  nmap('<leader>fb', telescope_builtins.buffers)
  nmap('<leader>fh', telescope_builtins.help_tags)
  nmap('<leader>fm', telescope_builtins.man_pages)
end

nmap('<leader>fa', '<cmd>Telescope telescope-alternate alternate_file<CR>')

tmap('<esc>', [[<C-\><C-n>]])

nmap('<leader>xx', '<cmd>TroubleToggle document_diagnostics<CR>')

nmap('<leader>n', '<cmd>NvimTreeToggle<CR>')

-- Todos
local todo_comments_ok, todo_comments = pcall(require, 'todo-comments')
if todo_comments_ok then
  nmap(']t', todo_comments.jump_next, { desc = 'Next todo comment' })
  nmap('[t', todo_comments.jump_prev, { desc = 'Previous todo comment' })
end

-----------------------------------------------------------------------
-- Spec keymaps
-----------------------------------------------------------------------
local function run_current_spec_file()
  -- neotest.run.run(vim.fn.expand('%'))
  fn.RunCurrentSpecFile()
end

local function run_nearest_spec()
  -- neotest.run.run()
  fn.RunNearestSpec()
end

local function run_last_spec()
  -- neotest.run.run_last()
  fn.RunLastSpec()
end

local function run_all_specs()
  -- neotest.summary.open()
  -- neotest.run.run(vim.fn.getcwd())
  fn.RunAllSpecs()
end

-- local function open_spec_summary()
--   neotest.summary.toggle()
-- end

-- local function cancel_spec_run()
--   neotest.run.stop()
-- end

nmap('<leader>sf', run_current_spec_file)
nmap('<leader>sn', run_nearest_spec)
nmap('<leader>sa', run_all_specs)
nmap('<leader>sl', run_last_spec)
-- nmap('<leader>ss', open_spec_summary)
-- nmap('<leader>sc', cancel_spec_run)

-----------------------------------------------------------------------
-- LSP keymaps
-----------------------------------------------------------------------

local action_preview_ok, action_preview = pcall(require, 'actions-preview')
local lsp_buf = vim.lsp.buf
local diagnostic = vim.diagnostic

local function get_code_action()
  if action_preview_ok then return action_preview.code_actions end

  return lsp_buf.code_action
end

local function standard_on_attach(client, buffnr)
  local bufopts = { noremap = true, silent = true, buffer = buffnr }
  local code_action = get_code_action()

  nmap('K', lsp_buf.hover, bufopts)
  nmap('<leader>gh', lsp_buf.signature_help, bufopts)
  nmap('<leader>ca', code_action, bufopts)
  nmap('<leader>rn', lsp_buf.rename, bufopts)
  nmap('[d', diagnostic.goto_prev, bufopts)
  nmap(']d', diagnostic.goto_next, bufopts)
end


local function telescope_on_attach(client, buffnr)
  local bufopts = { noremap = true, silent = true, buffer = buffnr }
  nmap('gc', telescope_builtins.lsp_incoming_calls, bufopts)
  nmap('<leader>fs', telescope_builtins.lsp_document_symbols)
  nmap('<leader>fw', telescope_builtins.lsp_workspace_symbols)
end

local function glance_on_attach(client, buffnr)
  local bufopts = { noremap = true, silent = true, buffer = buffnr }
  nmap('gr', '<CMD>Glance references<CR>', bufopts)
  nmap('gd', '<CMD>Glance definitions<CR>', bufopts)
end

nvim_config.on_attach = function(client, buffnr)
  standard_on_attach(client, buffnr)

  if telescope_builtins_ok then
    telescope_on_attach(client, buffnr)
  end

  if glance_ok then
    glance_on_attach(client, buffnr)
  end
end

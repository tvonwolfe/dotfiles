MODES = {
  normal = 'n',
  insert = 'i',
  visual = 'v',
  terminal = 't',
}

local cmd = vim.cmd

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

local dap_ok, dap = pcall(require, 'dap')

if dap_ok then
  local widgets = require('dap.ui.widgets')
  nmap('<F3>', dap.clear_breakpoints)
  nmap('<F4>', dap.toggle_breakpoint)

  nmap('<F5>', dap.continue)
  nmap('<F6>', dap.run_last)

  nmap('<F8>', dap.step_over)
  nmap('<F9>', dap.step_into)
  nmap('<F10>', dap.step_out)

  nmap('<leader>dh', widgets.hover)
end

-- Telescope & Glance
local telescope_builtins_ok, telescope_builtins = pcall(require, 'telescope.builtin')
local glance_ok, _glance = pcall(require, 'glance')

if telescope_builtins_ok then
  nmap('<leader>ff', telescope_builtins.find_files)
  nmap('<leader>fg', telescope_builtins.live_grep)
  nmap('<leader>fb', telescope_builtins.buffers)
  nmap('<leader>fh', telescope_builtins.help_tags)
  nmap('<leader>fm', telescope_builtins.man_pages)
  nmap('<leader>bh', telescope_builtins.git_bcommits)
end

nmap('<leader>fa', '<cmd>Telescope telescope-alternate alternate_file<CR>')

tmap('<esc>', [[<C-\><C-n>]])

nmap('<leader>xx', '<cmd>Trouble diagnostics toggle<CR>')

nmap('<leader>t', '<cmd>NvimTreeToggle<CR>')

-- Todos
local todo_comments_ok, todo_comments = pcall(require, 'todo-comments')
if todo_comments_ok then
  nmap(']t', todo_comments.jump_next, { desc = 'Next todo comment' })
  nmap('[t', todo_comments.jump_prev, { desc = 'Previous todo comment' })
end

-----------------------------------------------------------------------
-- Context keymaps
-----------------------------------------------------------------------
local function jump_to_context()
  local context_ok, context = pcall(require, 'treesitter-context')
  if not context_ok then return end

  context.go_to_context(vim.v.count1)
end
nmap("[c", jump_to_context)

-----------------------------------------------------------------------
-- Spec keymaps
-----------------------------------------------------------------------
local neotest = require('neotest')

local function run_current_spec_file()
  neotest.run.run(vim.fn.expand('%'))
end

local function run_nearest_spec()
  neotest.run.run()
end

local function debug_nearest_spec()
  neotest.run.run({ strategy = 'dap' })
end

local function run_last_spec()
  neotest.run.run_last()
end

local function run_all_specs()
  neotest.summary.open()
  neotest.run.run(vim.fn.getcwd())
end

local function open_spec_summary()
  neotest.summary.toggle()
end

local function cancel_spec_run()
  neotest.run.stop()
end

local function watch_spec_file()
  neotest.watch.toggle(vim.fn.expand('%'))
end

nmap('<leader>sf', run_current_spec_file)
nmap('<leader>sn', run_nearest_spec)
nmap('<leader>sa', run_all_specs)
nmap('<leader>sl', run_last_spec)
nmap('<leader>ss', open_spec_summary)
nmap('<leader>sc', cancel_spec_run)
nmap('<leader>sd', debug_nearest_spec)
nmap('<leader>sw', watch_spec_file)

-----------------------------------------------------------------------
-- LSP keymaps
-----------------------------------------------------------------------
local lsp_buf = vim.lsp.buf

nvim_config.on_attach = function(client, buffnr)
  local bufopts = { noremap = true, silent = true, buffer = buffnr }

  nmap('<leader>gh', lsp_buf.signature_help, bufopts)
  nmap('<leader>ca', lsp_buf.code_action, bufopts)
  nmap('<leader>rn', lsp_buf.rename, bufopts)

  if telescope_builtins_ok then
    nmap('gc', telescope_builtins.lsp_incoming_calls, bufopts)
    nmap('<leader>fs', telescope_builtins.lsp_document_symbols)
    nmap('<leader>fw', telescope_builtins.lsp_workspace_symbols)
    nmap('<leader>fd', function() telescope_builtins.diagnostics({ bufnr = 0 }) end)
  end

  if glance_ok then
    nmap('gr', '<CMD>Glance references<CR>', bufopts)
    nmap('gd', '<CMD>Glance definitions<CR>', bufopts)
  end
end

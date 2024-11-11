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

-- sideways.vim
nmap('<C-n>', '<cmd>SidewaysLeft<CR>', { desc = 'Move current method/function param one position to the left' })
nmap('<C-p>', '<cmd>SidewaysRight<CR>', { desc = 'Move current method/function param one position to the right' })

nmap('<leader>fu', '<cmd>CellularAutomaton make_it_rain<CR>', { desc = 'Make it rain' })

-- docker tools
nmap('<leader>dt', '<cmd>DockerToolsToggle<CR>', { desc = 'Toggle Docker tools window' })

-- jump between git change hunks
local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')

if gitsigns_ok then
  nmap('[g', gitsigns.prev_hunk, { desc = 'Jump to previous git change hunk' })
  nmap(']g', gitsigns.next_hunk, { desc = 'Jump to next git change hunk' })
end

local dap_ok, dap = pcall(require, 'dap')

if dap_ok then
  local widgets = require('dap.ui.widgets')
  nmap('<F3>', dap.clear_breakpoints, { desc = 'Clear all breakpoints' })
  nmap('<F4>', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })

  nmap('<F5>', dap.continue, { desc = 'Continue debugging' })
  nmap('<F6>', dap.run_last, { desc = 'Run last configuration' })

  nmap('<F8>', dap.step_over, { desc = 'Step over current statement' })
  nmap('<F9>', dap.step_into, { desc = 'Step into function/method call' })
  nmap('<F10>', dap.step_out, { desc = 'Step out of current function/method' })

  nmap('<leader>dh', widgets.hover, { desc = 'Show hover information in debugger' })
end

-- Telescope & Glance
local telescope_builtins_ok, telescope_builtins = pcall(require, 'telescope.builtin')
local glance_ok, _glance = pcall(require, 'glance')

if telescope_builtins_ok then
  nmap('<leader>ff', telescope_builtins.find_files, { desc = 'List & search files by filename' })
  nmap('<leader>fg', telescope_builtins.live_grep, { desc = 'Grep files in workspace' })
  nmap('<leader>fb', telescope_builtins.buffers, { desc = 'List open buffers' })
  nmap('<leader>fh', telescope_builtins.help_tags, { desc = 'List & search Vim helptags' })
  nmap('<leader>fm', telescope_builtins.man_pages, { desc = 'List & search man pages' })
  nmap('<leader>bh', telescope_builtins.git_bcommits, { desc = 'List git commits for current buffer' })
end

nmap('<leader>fa', '<cmd>Telescope telescope-alternate alternate_file<CR>', { desc = 'Find alternate file' })

tmap('<esc>', [[<C-\><C-n>]], { desc = 'Enable pressing <esc> to exit insert mode in a terminal buffer' })

nmap('<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'toggle Trouble diagnostics window' })

nmap('<leader>t', '<cmd>NvimTreeToggle<CR>', { desc = 'Toggle Nvim Tree' })

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

nmap('<leader>sf', run_current_spec_file, { desc = 'Run current spec file' })
nmap('<leader>sn', run_nearest_spec, { desc = 'Run nearest spec' })
nmap('<leader>sa', run_all_specs, { desc = 'Run all specs' })
nmap('<leader>sl', run_last_spec, { desc = 'Run last spec' })
nmap('<leader>ss', open_spec_summary, { desc = 'Open spec summary' })
nmap('<leader>sc', cancel_spec_run, { desc = 'Cancel current spec run' })
nmap('<leader>sd', debug_nearest_spec, { desc = 'Debug nearest spec' })
nmap('<leader>sw', watch_spec_file, { desc = 'Watch current spec file' })

-----------------------------------------------------------------------
-- LSP keymaps
-----------------------------------------------------------------------
local lsp_buf = vim.lsp.buf

nvim_config.on_attach = function(_client, buffnr)
  local opts = { buffer = buffnr }

  opts.desc = 'Show signature help'
  nmap('<leader>gh', lsp_buf.signature_help, opts)

  opts.desc = 'Show available LSP code actions'
  nmap('<leader>ca', lsp_buf.code_action, opts)

  opts.desc = 'Rename symbol'
  nmap('<leader>rn', lsp_buf.rename, opts)

  if telescope_builtins_ok then
    opts.desc = 'List function call locations'
    nmap('gc', telescope_builtins.lsp_incoming_calls, opts)

    opts.desc = 'List defined symbols for the current file'
    nmap('<leader>fs', telescope_builtins.lsp_document_symbols)

    opts.desc = 'List defined symbols for the current project'
    nmap('<leader>fw', telescope_builtins.lsp_workspace_symbols)

    opts.desc = 'List diagnostics for the current file'
    nmap('<leader>fd', function() telescope_builtins.diagnostics({ bufnr = 0 }) end)
  end

  if glance_ok then
    opts.desc = 'Show references to the symbol under the cursor'
    nmap('gr', '<CMD>Glance references<CR>', opts)

    opts.desc = 'Show definitions of the symbol under the cursor'
    nmap('gd', '<CMD>Glance definitions<CR>', opts)
  end
end

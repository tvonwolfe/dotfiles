MODES = {
  normal = 'n',
  insert = 'i',
  visual = 'v',
  terminal = 't',
}

local vim = vim
local fn = vim.fn

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

vim.cmd('noremap <C-b> :noh<CR>:call clearmatches()<CR>')

vim.g.mapleader = ' '

-- figure this guy out
vmap('//', "y/<C-R><CR><CR>")

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
nmap('<C-]>', '<cmd>SidewaysLeft<CR>')
nmap('<C-[>', '<cmd>SidewaysRight<CR>')

-- toggleterm
nmap('<leader>t', '<cmd>ToggleTerm<CR>')

nmap('<leader>fu', '<cmd>CellularAutomaton make_it_rain<CR>')

-- Telescope
local status, telescope_builtins = pcall(require, 'telescope.builtin')

if status then
  nmap('<leader>ff', telescope_builtins.find_files)
  nmap('<leader>fs', telescope_builtins.lsp_document_symbols)
  nmap('<leader>fw', telescope_builtins.lsp_workspace_symbols)
  nmap('<leader>fg', telescope_builtins.live_grep)
  nmap('<leader>fb', telescope_builtins.buffers)
  nmap('<leader>fh', telescope_builtins.help_tags)
  nmap('<leader>fm', telescope_builtins.man_pages)
end

nmap('<leader>fa', '<cmd>Telescope telescope-alternate alternate_file<CR>')

tmap('<esc>', [[<C-\><C-n>]])

nmap('<leader>xx', '<cmd>TroubleToggle<CR>')

nmap('<leader>n', '<cmd>NvimTreeToggle<CR>')

-----------------------------------------------------------------------
-- Neotest keymaps
-----------------------------------------------------------------------
local function run_current_spec_file()
  require('neotest').run.run(vim.fn.expand('%'))
  -- fn.RunCurrentSpecFile()
end

local function run_nearest_spec()
  require('neotest').run.run()
  -- fn.RunNearestSpec()
end

local function run_last_spec()
  fn.RunLastSpec()
end

local function run_all_specs()
  local neotest = require('neotest')
  neotest.summary.open()
  neotest.run.run(vim.fn.getcwd())
  -- fn.RunAllSpecs()
end

local function open_spec_summary()
  require('neotest').summary.toggle()
end

local function cancel_spec_run()
  require('neotest').run.stop()
end

nmap('<leader>sf', run_current_spec_file)
nmap('<leader>sn', run_nearest_spec)
nmap('<leader>sa', run_all_specs)
nmap('<leader>sl', run_last_spec)
nmap('<leader>ss', open_spec_summary)
nmap('<leader>sc', cancel_spec_run)

-----------------------------------------------------------------------
-- LSP keymaps
-----------------------------------------------------------------------

nvim_config.on_attach = function(client, buffnr)
  local bufopts = { noremap = true, silent = true, buffer = buffnr }
  nmap('gd', vim.lsp.buf.definition, bufopts)
  nmap('K', vim.lsp.buf.hover, bufopts)
  nmap('gh', vim.lsp.buf.signature_help, bufopts)
  nmap('ca', vim.lsp.buf.code_action, bufopts)
  nmap('gc', vim.lsp.buf.incoming_calls, bufopts)
  nmap('gr', vim.lsp.buf.references, bufopts)
  nmap('rn', vim.lsp.buf.rename, bufopts)
  -- nmap('gs', vim.lsp.buf.document_symbol, bufopts)
  nmap('gw', vim.lsp.buf.workspace_symbol, bufopts)
  nmap('[d', vim.diagnostic.goto_prev, bufopts)
  nmap(']d', vim.diagnostic.goto_next, bufopts)
  nmap('<leader>ds', vim.diagnostic.show, bufopts)
  nmap('<leader>dh', vim.diagnostic.hide, bufopts)
end

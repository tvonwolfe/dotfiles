local lsp = vim.lsp
local lspconfig = require 'lspconfig'
pcall(require, 'neodev')
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local nvim_lsp_protocol = lsp.protocol
local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())
local lsp_format = require 'lsp-format'
lsp_format.setup()

local function default_handler(server_name, cmd)
  local setup_args = {
    capabilities = capabilities,
    single_file_support = true,
    on_attach = function(client, bufnr)
      nvim_config.on_attach(client, bufnr)
      -- lsp_format.on_attach(client)
    end
  }

  if cmd then
    setup_args.cmd = { cmd }
  end

  lspconfig[server_name].setup(setup_args)
end

local servers = {
  'clangd',
  'cssls',
  { 'elixirls', cmd = os.getenv("HOME") .. "/.local/bin/elixir-ls/language_server.sh" },
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'solargraph',
  'tailwindcss',
  'terraformls',
  'tsserver',
}

for _, server in ipairs(servers) do
  local cmd = nil
  local server_name = nil

  if type(server) == 'table' then
    server_name = server[1]
    cmd = server.cmd
  else
    server_name = server
  end

  default_handler(server_name, cmd)
end

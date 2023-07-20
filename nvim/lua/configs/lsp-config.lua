local lsp = vim.lsp
local lspconfig = require 'lspconfig'
pcall(require, 'neodev')
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
local nvim_lsp_protocol = lsp.protocol
local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())
local lsp_format = require 'lsp-format'

local function default_handler(server_name)
  local setup_args = {
    capabilities = capabilities,
    single_file_support = true,
    on_attach = function(client, bufnr)
      nvim_config.on_attach(client, bufnr)
      lsp_format.on_attach(client)
    end
  }
  lspconfig[server_name].setup(setup_args)
end

local servers = {
  'solargraph',
  'tsserver',
  'lua_ls',
  'html',
  'cssls'
}

for _, server in ipairs(servers) do
  default_handler(server)
end

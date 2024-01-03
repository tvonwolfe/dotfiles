local mason_ok, mason = pcall(require, 'mason')
local mason_lsp_config_ok, mason_lsp_config = pcall(require, 'mason-lspconfig')
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local lsp_format_ok, lsp_format = pcall(require, 'lsp-format')
local nvim_lsp_config_ok, nvim_lsp_config = pcall(require, 'lspconfig')
local neodev_ok, neodev = pcall(require, 'neodev')
if not (lsp_format_ok and mason_ok and mason_lsp_config_ok and cmp_nvim_lsp_ok and nvim_lsp_config_ok) then return end

if neodev_ok then neodev.setup() end

local nvim_lsp_protocol = vim.lsp.protocol
local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())

lsp_format.setup()
mason.setup()

mason_lsp_config.setup {
  ensure_installed = {
    'cssls',
    'html',
    'jsonls',
    'lua_ls',
    'marksman',
    'tsserver',
  }
}

mason_lsp_config.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    local setup_args = {
      capabilities = capabilities,
      single_file_support = true,
      on_attach = function(client, bufnr)
        nvim_config.on_attach(client, bufnr)
        -- lsp_format.on_attach(client)
      end
    }
    nvim_lsp_config[server_name].setup(setup_args)
  end,
}

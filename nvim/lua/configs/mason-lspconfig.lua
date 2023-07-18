local result, mason = pcall(require, 'mason')
local neodev = pcall(require, 'neodev')

if result then
  local mason_lsp_config = require 'mason-lspconfig'
  local cmp_nvim_lsp = require 'cmp_nvim_lsp'
  local nvim_lsp_protocol = vim.lsp.protocol
  local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())

  local lsp_format = require 'lsp-format'

  mason.setup()

  mason_lsp_config.setup {
    ensure_installed = {
      'solargraph',
      'tsserver',
      'lua_ls',
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
          lsp_format.on_attach(client)
        end
      }
      require("lspconfig")[server_name].setup(setup_args)
    end,
  }
end

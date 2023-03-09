local result, mason = pcall(require, 'mason')

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
    }
  }

  mason_lsp_config.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        capabilities = capabilities,
        single_file_support = true,
        on_attach = function(client, bufnr)
          nvim_config.on_attach(client, bufnr)
          lsp_format.on_attach(client)
        end
      }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
      require("rust-tools").setup {}
    end
  }
end
local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local nvim_lsp_config_ok, nvim_lsp_config = pcall(require, 'lspconfig')
local neodev_ok, neodev = pcall(require, 'neodev')
if not (cmp_nvim_lsp_ok and nvim_lsp_config_ok) then return end

if neodev_ok then neodev.setup() end

local nvim_lsp_protocol = vim.lsp.protocol
local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())

local default_setup_args = {
  capabilities = capabilities,
  single_file_support = true,
  on_attach = function(client, bufnr)
    nvim_config.on_attach(client, bufnr)
  end
}

local servers = {
  bashls = {
    filetypes = { 'sh', 'zsh', 'bash' },
  },
  'cssls',
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true
        },
        staticcheck = true,
        gofumpt = true,
      }
    }
  },
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  markdown_oxide = {
    capabilities = vim.tbl_extend('force', capabilities, {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }),
  },
  'rust_analyzer',
  'solargraph',
  ruby_lsp = {
    init_options = {
      indexing = {
        includedPatterns = {
          "**/spec/**/*.rb",
        },
      },
    },
  },
  'tailwindcss',
  'ts_ls',
}

for k, v in pairs(servers) do
  local has_config = type(v) == "table"
  local server_name = has_config and k or v
  local additional_server_config = has_config and v or {}

  local setup_args = vim.tbl_extend('force', default_setup_args, additional_server_config)
  nvim_lsp_config[server_name].setup(setup_args)
end

local lint_ok, lint = pcall(require, 'lint')
if not lint_ok then return end

lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
local lsp_format_ok, lsp_format = pcall(require, 'lsp-format')
local nvim_lsp_config_ok, nvim_lsp_config = pcall(require, 'lspconfig')
local neodev_ok, neodev = pcall(require, 'neodev')
if not (lsp_format_ok and cmp_nvim_lsp_ok and nvim_lsp_config_ok) then return end

if neodev_ok then neodev.setup() end

local nvim_lsp_protocol = vim.lsp.protocol
local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())

lsp_format.setup()

local servers = {
  'cssls',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'markdown_oxide',
  'rust_analyzer',
  'solargraph',
  'tailwindcss',
  'tsserver',
}

for _, server_name in ipairs(servers) do
  if server_name == 'markdown_oxide' then
    capabilities.workspace = {
      didChangeWatchedFiles = {
        dynamicRegistration = true,
      },
    }
  end

  local setup_args = {
    capabilities = capabilities,
    single_file_support = true,
    on_attach = function(client, bufnr)
      nvim_config.on_attach(client, bufnr)
      -- lsp_format.on_attach(client)
    end
  }
  nvim_lsp_config[server_name].setup(setup_args)
end

local lint_ok, lint = pcall(require, 'lint')
if not lint_ok then return end

lint.linters_by_ft = {
  markdown = { 'markdownlint' },
}

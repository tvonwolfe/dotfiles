local cmp_nvim_lsp = require('cmp_nvim_lsp')
local telescope_builtins = require('telescope.builtin')

-- servers to enable
vim.lsp.enable({
  'bashls',
  'cssls',
  'html',
  'jsonls',
  'lua_ls',
  'markdown_oxide',
  'ruby_lsp',
  'tailwindcss',
  'ts_ls',
  'zls',
})

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
vim.o.completeopt = "menu,menuone,popup,fuzzy,noselect"

-- apply these settings to all LSP configs
vim.lsp.config('*', { capabilities = capabilities, single_file_support = true, })

-- this is essentially default `on_attach`, and allows other lsp config
-- definitions to declare their own `on_attach` function that will not conflict
-- with this autocmd's callback.
local group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true })
vim.api.nvim_create_autocmd('LspAttach', {
  group = group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    vim.lsp.completion.enable(true, ev.data.client_id, bufnr, { autotrigger = true, })

    if client and client.server_capabilities.codeLensProvider then
      vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
      })
    end

    -- setup keybindings
    local opts = { buffer = bufnr }
    opts.desc = 'List function call locations'
    vim.keymap.set('n', 'gc', telescope_builtins.lsp_incoming_calls, opts)

    opts.desc = 'List defined symbols for the current file'
    vim.keymap.set('n', '<leader>fs', telescope_builtins.lsp_document_symbols)

    opts.desc = 'List defined symbols for the current project'
    vim.keymap.set('n', '<leader>fw', telescope_builtins.lsp_workspace_symbols)

    opts.desc = 'List diagnostics for the current file'
    vim.keymap.set('n', '<leader>fd', function() telescope_builtins.diagnostics({ bufnr = 0 }) end)

    opts.desc = 'Show references to the symbol under the cursor'
    vim.keymap.set('n', 'gr', telescope_builtins.lsp_references, opts)

    opts.desc = 'Show definitions of the symbol under the cursor'
    vim.keymap.set('n', 'gd', telescope_builtins.lsp_definitions, opts)

    -- run codelens actions
    vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { noremap = true, silent = true })
  end
})

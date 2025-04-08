return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-nvim-lsp'
  },
  event = 'InsertEnter',
  config = function()
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local nvim_lsp_config = require('lspconfig')
    local telescope_builtins = require('telescope.builtin')
    local keymap = require('config.keymaps')
    local nmap = keymap.nmap

    require('neodev').setup()

    local nvim_lsp_protocol = vim.lsp.protocol
    local capabilities = cmp_nvim_lsp.default_capabilities(nvim_lsp_protocol.make_client_capabilities())

    local lsp_buf = vim.lsp.buf

    local default_setup_args = {
      capabilities = capabilities,
      single_file_support = true,
      on_attach = function(client, bufnr) end
    }

    local servers = {
      bashls = {
        filetypes = { 'sh', 'zsh', 'bash' },
      },
      'cssls',
      'gopls',
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
      'rubocop',
      ruby_lsp = {
        init_options = {
          indexing = {
            includedPatterns = {
              "**/spec/**/*.rb",
            },
          },
        },
        on_attach = function(client, bufnr)
          vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { noremap = true, silent = true })
          client.commands = client.commands or {}

          client.commands['rubyLsp.openFile'] = function(command)
            local file_path = command.arguments[1][1]

            local path, line = string.match(file_path, '(.+)#L(%d+)')
            path = path or file_path -- if no line number, use the whole path

            path = string.gsub(path, 'file://', '')
            vim.cmd('edit ' .. path)

            if line then
              vim.cmd(line)
            end
          end
        end,
      },
      'ts_ls',
      'zls',
    }

    local work_ok, work = pcall(require, 'config.work')

    if work_ok then
      -- overwrite server config if we're at work
      servers = work.lsp_servers
    end

    for k, v in pairs(servers) do
      local has_config = type(v) == "table"
      local server_name = has_config and k or v
      local additional_server_config = has_config and v or {}

      local setup_args = vim.tbl_extend('force', default_setup_args, additional_server_config)
      local server_on_attach = setup_args.on_attach

      setup_args.on_attach = function(client, bufnr)
        if client and client.server_capabilities.codeLensProvider then
          vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
            buffer = bufnr,
            callback = vim.lsp.codelens.refresh,
          })
        end
        local opts = { buffer = bufnr }

        opts.desc = 'Show signature help'
        nmap('<leader>gh', lsp_buf.signature_help, opts)

        opts.desc = 'Show available LSP code actions'
        nmap('<leader>ca', lsp_buf.code_action, opts)

        opts.desc = 'Rename symbol'
        nmap('<leader>rn', lsp_buf.rename, opts)

        opts.desc = 'List function call locations'
        nmap('gc', telescope_builtins.lsp_incoming_calls, opts)

        opts.desc = 'List defined symbols for the current file'
        nmap('<leader>fs', telescope_builtins.lsp_document_symbols)

        opts.desc = 'List defined symbols for the current project'
        nmap('<leader>fw', telescope_builtins.lsp_workspace_symbols)

        opts.desc = 'List diagnostics for the current file'
        nmap('<leader>fd', function() telescope_builtins.diagnostics({ bufnr = 0 }) end)

        opts.desc = 'Show references to the symbol under the cursor'
        nmap('gr', '<CMD>Glance references<CR>', opts)

        opts.desc = 'Show definitions of the symbol under the cursor'
        nmap('gd', '<CMD>Glance definitions<CR>', opts)

        server_on_attach(client, bufnr)
      end
      nvim_lsp_config[server_name].setup(setup_args)
    end
  end,
}

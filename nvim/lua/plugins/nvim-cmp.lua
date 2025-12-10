return {
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  'tailwind-tools',
  { 'onsails/lspkind.nvim', lazy = true },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local cmp_context = require('cmp.config.context')
      local lspkind = require('lspkind')

      local lspkind_formatting = lspkind.cmp_format({ mode = 'symbol_text', symbol_map = { Copilot = '' } })

      cmp.setup {
        enabled = function()
          if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end

          -- disable completion in comments
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not cmp_context.in_treesitter_capture("comment")
                and not cmp_context.in_syntax_group("Comment")
          end
        end,
        formatting = { format = lspkind_formatting },
        sources = cmp.config.sources({
          { name = 'nvim_lsp',
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
              }
            }
          },
          { name = 'copilot' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        window = {
          completion = { winblend = 15 },
          documentation = { winblend = 15 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "c", "i" }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { "c", "i" }),
          ['<CR>'] = cmp.mapping.confirm({ select = false })
        })
      }
    end
  },
}

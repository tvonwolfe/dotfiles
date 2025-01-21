return {
  'rafamadriz/friendly-snippets',
  { 'L3MON4D3/LuaSnip',         build = "make install_jsregexp", lazy = true },
  { 'onsails/lspkind.nvim',     lazy = true },
  { 'saadparwaiz1/cmp_luasnip', lazy = true },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer'
    },
    config = function()
      local cmp = require('cmp')
      local cmp_context = require('cmp.config.context')
      local lspkind = require('lspkind')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()

      local lspkind_formatting = lspkind.cmp_format({ mode = 'symbol_text', symbol_map = { Copilot = '' } })

      luasnip.filetype_extend('ruby', { 'rails' })

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
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp',
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
              }
            }
          },
          { name = 'nvim_lsp_signature_help' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'luasnip' },
          { name = 'copilot',                group_index = 2 },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expandable() then
              luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
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

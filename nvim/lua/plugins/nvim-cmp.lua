return {
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = function()
      local cmp = require('cmp')
      local cmp_context = require('cmp.config.context')

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
      end

      cmp.setup({
        view = {
          docs = {
            auto_open = false
          }
        },
        enabled = function()
          if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then return false end

          -- disable completion in comments
          -- keep command mode completion enabled when cursor is in a comment
          if vim.api.nvim_get_mode().mode == 'c' then
            return true
          else
            return not cmp_context.in_treesitter_capture("comment")
                and not cmp_context.in_syntax_group("Comment")
          end
        end,
        formatting = { fields = { 'abbr', 'kind' } },
        sources = cmp.config.sources({
          {
            name = 'nvim_lsp',
            option = {
              markdown_oxide = {
                keyword_pattern = [[\(\k\| \|\/\|#\)\+]]
              }
            }
          },
          { name = 'copilot' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'path' },
        }),
        window = {
          completion = { winblend = 15 },
          documentation = { winblend = 15 },
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-g>'] = cmp.mapping(function()
            if cmp.visible_docs() then
              cmp.close_docs()
            else
              cmp.open_docs()
            end
          end),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if not cmp.select_next_item() then
              if vim.bo.buftype ~= 'prompt' and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if not cmp.select_prev_item() then
              if vim.bo.buftype ~= 'prompt' and has_words_before() then
                cmp.complete()
              else
                fallback()
              end
            end
          end, { "i", "s" }),
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "c", "i" }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { "c", "i" }),
          ['<CR>'] = cmp.mapping.confirm({ select = false })
        })
      })
    end
  },
}

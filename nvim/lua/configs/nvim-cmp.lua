local cmp = require 'cmp'
local vim = vim
local lspkind_status_ok, lspkind = pcall(require, 'lspkind')
local snip_status_ok, luasnip = pcall(require, 'luasnip')

if not snip_status_ok then return end

local lspkind_formatting = lspkind_status_ok and lspkind.cmp_format({ mode = 'symbol_text' }) or nil

local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

cmp.setup {
  enabled = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
    return true
  end,
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  preselect = cmp.PreselectMode.None,
  formatting = { format = lspkind_formatting },
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  confirmation = { completeopt = 'menu,menuone,noinsert' },
  mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
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
  }),
  experimental = {
    ghost_text = true
  }
}

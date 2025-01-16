return {
  'monaqa/dial.nvim',
  lazy = true,
  opts = function()
    local augend = require('dial.augend')

    return {
      groups = {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
        }
      }
    }
  end,
  config = function(_, opts)
    for name, group in pairs(opts.groups) do
      if name ~= "default" then
        vim.list_extend(group, opts.groups.default)
      end
    end

    require('dial.config').augends:register_group(opts.groups)
  end,
  keys = {
    { '<C-a>', function() require('dial.map').manipulate('increment', 'normal') end },
    { '<C-x>', function() require('dial.map').manipulate('decrement', 'normal') end }
  },
}

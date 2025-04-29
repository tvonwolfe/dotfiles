local M = {}

local defaults = {
  dark = 'default',
  light = 'default',
  on_toggle = nil,
}

local function set_colorscheme()
  local theme = M.options[vim.o.background]
  if type(theme) == 'function' then
    theme()
  elseif type(theme) == 'string' then
    vim.cmd("colorscheme " .. theme)
  else
    vim.notify("Invalid colorscheme: " .. vim.inspect(theme), vim.log.levels.ERROR)
  end
end

local function setup_autocmds()
  vim.api.nvim_create_autocmd("OptionSet", {
    pattern = { "background" },
    callback = function()
      set_colorscheme()
      -- for some reason, this plugin doesn't play nicely with vim.o.background
      -- option changes
      vim.cmd("IBLEnable")
    end
  })
end

M.options = {}

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  setup_autocmds()
end

return M

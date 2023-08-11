local vim = vim
local M = {}

local defaults = {
  dark = 'default',
  light = 'morning',
  on_toggle = function(background) end,
}

local function set_colorscheme(theme)
  local status, _ = pcall(vim.cmd, 'colorscheme ' .. theme)

  if not status then
    print("ERROR: Couldn't set colorscheme to " .. theme)
  end

  return status
end

local function flip(background)
  if background == 'dark' then
    return 'light'
  else
    return 'dark'
  end
end

M.options = {}

local toggle = function()
  local theme = flip(vim.o.background)
  local colorscheme = M.options[theme] or M.options.dark
  set_colorscheme(colorscheme)
  vim.opt.background = theme

  if M.options.on_toggle then
    M.options.on_toggle(vim.o.background)
  end
end

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  local status = set_colorscheme(M.options[vim.o.background])

  if (not status) and opts.fallback ~= nil then
    set_colorscheme(M.options.fallback)
  end

  vim.api.nvim_create_user_command('ToggleColorscheme', toggle, {})
end

return M

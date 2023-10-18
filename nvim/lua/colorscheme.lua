local M = {}

local defaults = {
  dark = 'default',
  light = 'morning',
  on_toggle = function(_) end,
}

local function set_colorscheme(theme)
  local colorscheme_set_ok, _ = pcall(vim.cmd, 'colorscheme ' .. theme)

  if not colorscheme_set_ok then
    print("ERROR: Couldn't set colorscheme to " .. theme)
  end

  return colorscheme_set_ok
end

local function get_bg(background)
  if background == 'dark' then
    return 'light'
  else
    return 'dark'
  end
end

M.options = {}

local toggle = function()
  local background = get_bg(vim.o.background)
  local colorscheme = M.options[background] or M.options.dark

  if not set_colorscheme(colorscheme) then return end

  vim.opt.background = background

  if M.options.on_toggle then
    M.options.on_toggle(vim.o.background)
  end
end

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  local status = set_colorscheme(M.options[vim.o.background])

  if (not status) and M.options.fallback ~= nil then
    set_colorscheme(M.options.fallback)
  end

  vim.api.nvim_create_user_command('ToggleColorscheme', toggle, {})
end

return M

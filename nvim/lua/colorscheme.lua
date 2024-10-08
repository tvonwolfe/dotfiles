local M = {}

local defaults = {
  dark = 'default',
  light = 'morning',
  on_toggle = nil,
  bg_detect_fn = function() return vim.o.background end,
}

local function set_colorscheme(theme)
  local colorscheme_set_ok, _ = pcall(vim.cmd, 'colorscheme ' .. theme)

  if not colorscheme_set_ok then
    print("ERROR: Couldn't set colorscheme to " .. theme)
  end

  return colorscheme_set_ok
end

M.options = {}

local toggle = function()
  if M.options.on_toggle then
    M.options.on_toggle(vim.o.background)
  end

  local background = M.options.bg_detect_fn() or 'dark'
  local colorscheme = M.options[background] or M.options.dark

  vim.opt.background = background
  if not set_colorscheme(colorscheme) then return end
end

function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", {}, defaults, opts or {})

  local background = M.options.bg_detect_fn()
  local status = set_colorscheme(M.options[background])
  vim.opt.background = background

  if (not status) and M.options.fallback ~= nil then
    set_colorscheme(M.options.fallback)
  end

  vim.api.nvim_create_user_command('ToggleColorscheme', toggle, {})
end

return M

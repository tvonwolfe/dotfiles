local vim = vim

local colorscheme = {}
local options = {}
local state = nil

local function set_colorscheme(theme)
  local status, _result = pcall(vim.cmd, 'colorscheme ' .. theme)

  if not status then
    print("ERROR: Couldn't set colorscheme to " .. theme)
  end

  return status
end

local toggle = function()
  if state == 'default' then
    set_colorscheme(options.alternate or options.default)
    state = 'alternate'
  else
    set_colorscheme(options.default)
    state = 'default'
  end

  if options.toggle_callback then
    options.toggle_callback(vim.opt.background._value)
  end
end

local function set_initial_state()
  if options.on_startup then
    state = options.on_startup()
  else
    state = 'default'
  end
end

function colorscheme.setup(opts)
  options = vim.tbl_deep_extend("force", {}, options, opts or {})
  set_initial_state()

  local status = set_colorscheme(options[state])

  if (not status) and opts.fallback ~= nil then
    set_colorscheme(options.fallback)
  end
end

vim.api.nvim_create_user_command('ToggleColorscheme', toggle, {})

return colorscheme

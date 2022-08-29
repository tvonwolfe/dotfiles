local vim = vim

DEFAULT_COLORSCHEME = 'tokyonight-storm'

COLORSCHEMES = {
  dark = DEFAULT_COLORSCHEME,
  light = 'tokyonight-day'
}

local function is_tmux_running()
  return os.getenv('TMUX') ~= nil
end

local function fetch_colorscheme(theme)
  local colorscheme = COLORSCHEMES[theme]
  if colorscheme == nil then
    colorscheme = DEFAULT_COLORSCHEME
  end
  return colorscheme
end

local function get_tmux_theme_setting()
  local f = assert(io.popen('tmux show-environment THEME', "r"))
  local s = assert(f:read("a*"))
  f:close()

  local _, _, theme = string.find(s, "THEME=(%w*)")

  if not (theme == nil) then
    theme = string.gsub(theme, "%s+", "")
  end

  return theme
end

local function get_from_config_file()
  local filename = os.getenv('HOME') .. '/.flip'
  local f = assert(io.open(filename, 'r'))
  local contents = assert(f:read("*all"))
  f:close()

  local theme = string.gsub(contents, "%s+", "")

  return theme
end

local function set_colorscheme(theme)
  pcall(vim.cmd, 'colorscheme ' .. theme)
end

local function set_from_environment()
  local theme

  if is_tmux_running() then
    theme = get_tmux_theme_setting()
  else
    theme = get_from_config_file()
  end

  set_colorscheme(fetch_colorscheme(theme))
end

local function toggle()
  local _ = os.execute('flip')
  set_colorscheme(fetch_colorscheme(get_from_config_file()))
end

return {
  set_colorscheme_from_environment = set_from_environment,
  toggle_colorscheme = toggle,
}

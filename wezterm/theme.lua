local COLORSCHEMES = {
  dark = 'rose-pine',
  light = 'rose-pine-dawn',
}

local wezterm = require 'wezterm'
local utils = require('utils')

local os_name = utils.get_os()
local is_linux = os_name == 'linux'
local is_macos = os_name == 'darwin'

local get_colorscheme = function()
  -- TODO: make this dynamic
  return COLORSCHEMES.dark
end

local get_default_padding = function()
  local padding = {
    top = '1.7cell',
    bottom = 0,
    right = 0,
    left = 3,
  }

  if is_linux then
    padding.top = 3
  end

  return padding
end

local set_padding = function(window, _)
  local window_dims = window:get_dimensions()
  local overrides = window:get_config_overrides() or {}
  local padding = get_default_padding()

  if window_dims.is_full_screen then
    padding.top = 3
  end

  overrides.window_padding = padding

  window:set_config_overrides(overrides)
end

local setup = function()
  wezterm.on('window-resized', set_padding)
  wezterm.on('window-config-reloaded', set_padding)

  local config = {
    color_scheme = get_colorscheme(),
    font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
    line_height = 1.0,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    window_padding = get_default_padding()
  }

  if is_linux then
    config.font_size = 10
    config.window_decorations = 'NONE'
  elseif is_macos then
    config.window_decorations = 'INTEGRATED_BUTTONS | RESIZE'
  end

  return config
end

return {
  setup = setup,
  color_schemes = COLORSCHEMES
}

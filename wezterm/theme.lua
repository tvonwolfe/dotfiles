local COLORSCHEMES = {
  dark = {
    colors = {
      foreground = "#dcd7ba",
      background = "#1f1f28",

      cursor_bg = "#c8c093",
      cursor_fg = "#c8c093",
      cursor_border = "#c8c093",

      selection_fg = "#c8c093",
      selection_bg = "#2d4f67",

      scrollbar_thumb = "#16161d",
      split = "#16161d",

      ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
      brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
      indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
    }
  },
  light = { color_scheme = 'rose-pine-dawn' },
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
    force_reverse_video_cursor = true,
    font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
    line_height = 1.0,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    window_padding = get_default_padding()
  }

  config = utils.merge_tables(config, get_colorscheme())

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

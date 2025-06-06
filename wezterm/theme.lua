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

local get_colorscheme = function()
  -- TODO: make this dynamic
  return COLORSCHEMES.dark
end

local set_padding = function(window, _)
  local overrides = window:get_config_overrides() or {}

  window:set_config_overrides(overrides)
end

local setup = function()
  wezterm.on('window-resized', set_padding)
  wezterm.on('window-config-reloaded', set_padding)

  local config = {
    force_reverse_video_cursor = true,
    font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
    font_size = 10,
    window_decorations = 'NONE',
    line_height = 1.0,
    hide_tab_bar_if_only_one_tab = true,
    tab_bar_at_bottom = true,
    window_padding = {
      top = 3,
      bottom = 0,
      right = 0,
      left = 3,
    }
  }

  config = utils.merge_tables(config, get_colorscheme())

  return config
end

return {
  setup = setup,
  color_schemes = COLORSCHEMES
}

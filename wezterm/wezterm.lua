local wezterm = require 'wezterm'
local utils = require 'utils'

local config = wezterm.config_builder()

-- other stuff
local theming = require('theme')
local keymaps = require('keymaps')
local event_handling = require('events')

local theme_config = theming.setup()

-- event handlers
event_handling.setup({
  ['toggle-colorscheme'] = function(window, _)
    local overrides = window:get_config_overrides() or {}

    -- TODO: figure out how to make this work with color_scheme and colors
    if not overrides.color_scheme then
      overrides.color_scheme = theming.color_schemes.light
    else
      overrides.color_scheme = nil
    end

    window:set_config_overrides(overrides)
  end
})

-- plugins
require('plugin_manager').setup(function(use)
  use {
    'michaelbrusegard/tabline.wez',
    config = function(tabline)
      tabline.setup({ options = { theme = theme_config.color_scheme } })
      tabline.apply_to_config(config)
    end
  }
end)

-- merge tables here to ensure local settings take precedent over everything
-- else
config = utils.merge_tables(config, theme_config, keymaps)
config.term = 'wezterm'

return config

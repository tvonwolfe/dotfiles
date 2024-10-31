local wezterm = require('wezterm')

return {
  leader = { key = 'b', mods = 'CTRL' },
  keys = {
    {
      key = 't',
      mods = 'LEADER',
      action = wezterm.action.EmitEvent 'toggle-colorscheme',
    }
  },
}

local wezterm = require('wezterm')

local handler_setup = function(config)
  for event_name, handler in pairs(config) do
    wezterm.on(event_name, handler)
  end
end

return {
  setup = handler_setup
}

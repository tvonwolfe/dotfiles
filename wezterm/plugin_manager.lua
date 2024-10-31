local DEFAULT_PLUGIN_SETUP = {
  git_source = 'github',
}

local wezterm = require('wezterm')

local use = function(plugin)
  local is_table = type(plugin) == "table"
  local plugin_path;

  if is_table then
    plugin_path = plugin[1]
  else
    plugin_path = plugin
  end

  local git_source;
  if is_table then
    git_source = plugin.git_source
  end

  git_source = git_source or DEFAULT_PLUGIN_SETUP.git_source

  local source_url = 'https://' .. git_source .. '.com/' .. plugin_path
  local plugin_table = wezterm.plugin.require(source_url)

  if not is_table then return end

  if plugin.config then
    plugin.config(plugin_table)
  end
end

local setup = function(plugin_setup_fn)
  plugin_setup_fn(use)
end

return { setup = setup }

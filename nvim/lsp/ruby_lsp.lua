-- returns "standard" if the standard gem is present in the project,
-- "auto" otherwise
local formatter = function()
  local cwd = vim.fn.getcwd()
  local gemfile = cwd .. "/Gemfile"
  if vim.fn.filereadable(gemfile) == 1 then
    local lines = vim.fn.readfile(gemfile)
    local standard = '^%s*gem%s+["\']standard["\']'
    local standardrb = '^%s*gem%s+["\']standardrb["\']'

    for _, line in ipairs(lines) do
      if line:match(standard) or line:match(standardrb) then
        return "standard"
      end
    end
  end

  return "auto"
end

local config = {
  filetypes = { "ruby" },

  cmd = { "ruby-lsp" },

  init_options = {
    formatter = formatter(),
    linters = { formatter() }
  },

  root_markers = { "Gemfile", ".git" },

  reuse_client = function(client, config)
    config.cmd_cwd = config.root_dir
    return client.config.cmd_cwd == config.cmd_cwd
  end,
}

return config

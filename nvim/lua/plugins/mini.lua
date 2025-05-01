return {
  'echasnovski/mini.nvim',
  version = false,
  config = function()
    require('mini.pairs').setup()
    local sessions = require('mini.sessions')


    -- sessions setup
    -- sets up MiniSessions augroup with an autocmd that detects the current git
    -- branch and creates a sessions with the same name if it doesn't exist,
    -- triggered on startup
    --
    -- TODO: figure out why this doesn't work
    -- vim.api.nvim_create_augroup("MiniSessions", { clear = true })
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   group = "MiniSessions",
    --   callback = function()
    --     local branch = vim.fn.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" })
    --     branch = string.gsub(branch, "\n", "")
    --     if branch ~= "" then
    --       sessions.write("session_" .. branch)
    --     end
    --   end,
    -- })
  end,
}

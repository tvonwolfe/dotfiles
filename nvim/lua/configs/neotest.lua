local neotest = require('neotest')
local neotest_plenary = require('neotest-plenary')
local neotest_rspec = require('neotest-rspec')

neotest.setup {
  adapters = {
    neotest_plenary,
    neotest_rspec
  },
  icons = {
    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
    passed = "",
    failed = "",
    running = "",
    unknown = "",
    skipped = "",
  }
}

local neotest = require('neotest')
local neotest_plenary = require('neotest-plenary')
local neotest_rspec = require('neotest-rspec')
local neotest_jest = require('neotest-jest')

neotest.setup {
  adapters = {
    neotest_plenary,
    neotest_rspec,
    neotest_jest
  },
  icons = {
    running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
  }
}

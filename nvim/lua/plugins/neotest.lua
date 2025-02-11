return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'olimorris/neotest-rspec',
    'nvim-neotest/neotest-jest',
  },
  config = function()
    local neotest = require('neotest')
    local neotest_rspec = require('neotest-rspec')
    local neotest_jest = require('neotest-jest')

    neotest.setup {
      adapters = {
        neotest_rspec,
        neotest_jest,
      },
      icons = {
        running_animated = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
      }
    }
  end,
  keys = {
    {
      '<leader>sf',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      { desc = 'Run current spec file' },
    },
    {
      '<leader>sn',
      function()
        require('neotest').run.run()
      end,
      { desc = 'Run nearest spec' },
    },
    {
      '<leader>sa',
      function()
        local neotest = require('neotest')
        neotest.summary.open()
        neotest.run.run(vim.fn.getcwd())
      end,
      { desc = 'Run all specs in project' },
    },
    {
      '<leader>sl',
      function()
        require('neotest').run.run_last()
      end,
      { desc = 'Run last spec' }
    },
    {
      '<leader>ss',
      function()
        require('neotest').summary.toggle()
      end,
      { desc = 'Open spec summary pane' }
    },
    {
      '<leader>sc',
      function()
        require('neotest').run.stop()
      end,
      { desc = 'Cancel current spec run' }
    },
    {
      '<leader>sd',
      function()
        require('neotest').run.run({ strategy = 'dap' })
      end,
      { desc = 'Debug nearest spec' }
    },
    {
      '<leader>sw',
      function()
        require('neotest').watch.toggle(vim.fn.expand('%'))
      end,
      { desc = { 'Watch current spec file' } }
    }
  }
}

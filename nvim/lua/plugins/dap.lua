return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'liadoz/nvim-dap-repl-highlights',
    'nvim-neotest/nvim-nio'
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')
    local dap_repl_highlights = require('nvim-dap-repl-highlights')

    dap.adapters.ruby = function(callback, config)
      callback {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "rdbg",
          args = { "-n", "--open", "--port", "${port}",
            "-c", "--", "bundle", "exec", config.command, config.script,
          },
        },
      }
    end

    dap.configurations.ruby = {
      {
        type = "ruby",
        name = "debug current file",
        request = "attach",
        localfs = true,
        command = "ruby",
        script = "${file}",
      },
      {
        type = "ruby",
        name = "run current spec file",
        request = "attach",
        localfs = true,
        command = "rspec",
        script = "${file}",
      },
      {
        type = "ruby",
        name = "run spec at current line",
        request = "attach",
        localfs = true,
        command = "rspec",
        script = function()
          local script = "${file}"
          local line_number = vim.fn.line(".")
          return script .. ":" .. line_number
        end
      },
      {
        type = "ruby",
        name = "debug Rails server",
        request = "attach",
        localfs = true,
        command = "rails",
        script = "server",
      }
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dapui.setup()
    dap_repl_highlights.setup()
  end,
  keys = {
    {
      '<F3>',
      function()
        require('dap').clear_breakpoints()
      end,
      { desc = 'Clear all breakpoints' },
    },
    {
      '<F4>',
      function()
        require('dap').toggle_breakpoint()
      end,
      { desc = 'Toggle breakpoint at current line' },
    },
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      { desc = 'Continue/start debugging' },
    },
    {
      '<F6>',
      function()
        require('dap').run_last()
      end,
      { desc = 'Run last configuration' },
    },
    {
      '<F8>',
      function()
        require('dap').step_over()
      end,
      { desc = 'Step over statement' },
    },
    {
      '<F9>',
      function()
        require('dap').step_into()
      end,
      { desc = 'Step into function/method call' },
    },
    {
      '<F10>',
      function()
        require('dap').step_out()
      end,
      { desc = 'Step out of current function/method' },
    },
    {
      '<leader>dh',
      function()
        require('dap.ui.widgets').hover()
      end,
      { desc = 'Show hover information in debugger' },
    }
  }
}

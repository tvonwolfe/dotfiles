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
    name = "run spec in current file on current line",
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

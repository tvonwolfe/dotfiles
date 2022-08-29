local nvim_dap = require 'dap'

nvim_dap.adapters.ruby = {
  type = 'executable',
  command = 'bundle',
  args = { 'exec', 'readapt', 'stdio' },
}

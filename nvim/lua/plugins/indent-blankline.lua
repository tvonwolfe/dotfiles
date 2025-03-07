return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '│'
    },
    exclude = {
      buftypes = { "terminal", "nofile" },
      filetypes = {
        'text',
        'markdown',
        'man',
        'help',
        'terminal',
        'dashboard',
        'packer',
        'TelescopePrompt',
        'TelescopeResults',
        '',
      },
    }
  }
}

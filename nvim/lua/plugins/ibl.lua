return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  priority = 1,
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
        'TelescopePrompt',
        'TelescopeResults',
        '',
      },
    }
  }
}

local indent_blankline = require 'ibl'

indent_blankline.setup {
  exclude = { filetypes = { 'text', 'markdown', 'man' } }
}

return {
  'christoomey/vim-tmux-navigator',
  'folke/zen-mode.nvim',
  'tpope/vim-abolish',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-projectionist',
  'tpope/vim-bundler',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  { 'kylechui/nvim-surround', opts = {} },
  { 'rgroli/other.nvim',      opts = { mappings = { 'rails' } }, main = 'other-nvim' },
  { 'windwp/nvim-ts-autotag', opts = {},                         ft = { 'html', 'eruby', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } },
}

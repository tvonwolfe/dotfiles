local work_ok, work = pcall(require, 'config.work')

local work_plugins = {}

if work_ok then
  work_plugins = work.plugins()
end

return {
  'christoomey/vim-tmux-navigator',
  'tpope/vim-abolish',
  'tpope/vim-dispatch',
  'tpope/vim-fugitive',
  'tpope/vim-projectionist',
  'tpope/vim-bundler',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  { 'junegunn/gv.vim',        cmd = 'GV', },
  { 'kylechui/nvim-surround', opts = {} },
  { 'rgroli/other.nvim',      opts = { mappings = { 'rails' } }, main = 'other-nvim' },
  { 'tpope/vim-liquid',       ft = 'liquid', },
  { 'windwp/nvim-ts-autotag', opts = {},                         ft = { 'html', 'eruby', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' } },
  work_plugins
}

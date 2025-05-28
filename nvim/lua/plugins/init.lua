local work_ok, work = pcall(require, 'config.work')

local work_plugins = {}

if work_ok then
  work_plugins = work.plugins()
end

return {
  'bettervim/yugen.nvim',
  'christoomey/vim-tmux-navigator',
  'tpope/vim-abolish',
  'tpope/vim-dispatch',
  'tpope/vim-projectionist',
  'tpope/vim-rails',
  'tpope/vim-repeat',
  { 'Everblush/nvim',           name = 'everblush' },
  { 'folke/zen-mode.nvim',      opts = {},                         cmd = 'ZenMode',                                                                            lazy = true },
  { 'junegunn/gv.vim',          cmd = 'GV',                        lazy = true },
  { 'kylechui/nvim-surround',   opts = {} },
  { 'lewis6991/satellite.nvim', opts = {} },
  { 'rgroli/other.nvim',        opts = { mappings = { 'rails' } }, main = 'other-nvim' },
  { 'tpope/vim-bundler',        cmd = 'Bundle',                    lazy = true },
  { 'tpope/vim-fugitive',       cmd = 'Git',                       lazy = true },
  { 'tpope/vim-liquid',         ft = 'liquid',                     lazy = true },
  { 'windwp/nvim-ts-autotag',   opts = {},                         ft = { 'html', 'eruby', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' }, lazy = true },
  work_plugins
}

-- tailwind-tools.lua
return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig",         -- optional
  },
  opts = {
    keymaps = {
      smart_increment = {
        enabled = false -- interferes with dial.nvim otherwise
      }
    }
  }
}

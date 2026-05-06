<<<<<<< HEAD
-- lazy.nvim
=======
>>>>>>> 4ffd867 (c# support, treesitter config update)
return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    require("easy-dotnet").setup()
  end
}

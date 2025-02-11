return {
  "ergoproxy623/nvim-angular-selectors",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
  },
  enabled = true,
  config = function()
    require("angular-selectors"):setup {
      enable_on = { "html", "htmlangular", "angular" }, -- set the file types you want the plugin to work on
      file_extensions = { "ts" }, -- set the local filetypes from which you want to derive classes
    }
  end,
}

return {
   "ergoproxy623/nvim-html-css",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim"
        },
        enabled = true,
        config = function()
            require("html-css"):setup({
                 enable_on = {"html", "angular.html"}, -- set the file types you want the plugin to work on
            file_extensions = { "css", "sass", "less" }, -- set the local filetypes from which you want to derive classes
            }   
            )
        end
}

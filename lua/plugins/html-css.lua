return {
   "ergoproxy623/nvim-html-css",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim"
        },
        enabled = false,
    opts = {
      enable_file_patterns = { "*.html", "*angular.html"  },
    }      
}
return {
  {
    "ergoproxy623/nx.nvim",

    dependencies = {
      "nvim-telescope/telescope.nvim",
    },

    opts  = {
      -- See below for config options
      nx_cmd_root = "npx nx",
    },

    -- Plugin will load when you use these keys
    keys = {
      { "<leader>rx", "<cmd>Telescope nx actions<CR>", desc = "nx actions"},
      { "<leader>rg", "<cmd>Telescope nx generators<CR>", desc = "nx generators"},
    },
  },
}

if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      "css", 
      "html"
      -- add more arguments for adding more treesitter parsers
    })
    opts.rainbow = require('astrocore').list_insert_unique(opts.rainbow, {
        enable = true,
        disable = { "html" },
        extended_mode = false,
        max_file_lines = nil,
    }) 
  end,
}

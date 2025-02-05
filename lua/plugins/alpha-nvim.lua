return {
  "goolord/alpha-nvim",
  opts = function(_, opts) -- override the options using lazy.nvim
    local get_icon = require("astroui").get_icon
    opts.section.buttons.val = {
      opts.button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
      opts.button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
      opts.button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
      opts.button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
      opts.button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
      opts.button("LDR w s", get_icon("Search", 2, true) .. "Session List "),
    }
  end,
}

return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-emoji", -- add cmp source as dependency of cmp
    "jcha0713/cmp-tw2css",
    "Jezda1337/cmp_bootstrap",
    "amarakon/nvim-cmp-fonts",
    "roginfarrer/cmp-css-variables",
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources(
      {
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 600 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 750 },
        { name = "emoji", priority = 450 }, -- add new source
        { name = "html-css", priority = 500 },
        { name = "angular-selectors", priority = 500 },
        { name = "calc", priority = 10 },
        {
          name = "dictionary",
          keyword_length = 2,
          priority = 10,
        },
      },
      { name = "nvim_lsp_document_symbol" },
      { name = "cmp-tw2css" },
      { name = "color_names" },
      { name = "bootstrap" },
      { name = "fonts", priority = 10 },
      
      {
        name = "scss",
        option = {
          triggers = { "&" }, -- default value
          extension = ".scss", -- default value
          pattern = [=[\%(\s\|^\)\zs\$[[:alnum:]_\-0-9]*:\?]=], -- default value
          folders = { "/src" },
        },
      },
      { name = "sass-variables" },
      { name = "css-variables" },
      {
        name = "cmp_yanky",
        option = {
          -- only suggest items which match the current filetype
          onlyCurrentFiletype = false,
          -- only suggest items with a minimum length
          minLength = 3,
        },
        -- {
        --   name = 'yank',
        --  -- you can specify the directory to save yank history (optional)
        --   yank_source_path = vim.getenv("HOME") .. "/dotfiles/history"
        -- },
      }
    )
    opts.formatting = {
        format = function(entry, vim_item)
            if entry.source.name == "html-css" then
                vim_item.menu = entry.completion_item.menu
            end
            return vim_item
        end
    }
  end,
}

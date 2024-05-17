-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==
  "nvim-lua/plenary.nvim",
  "andweeb/presence.nvim",
  "rebelot/kanagawa.nvim",
  "nvim-treesitter/nvim-treesitter-context",
  "mbbill/undotree",
  "KabbAmine/vCoolor.vim",
  "gbprod/yanky.nvim",
  "neoclide/npm.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },
  {
  "vhyrro/luarocks.nvim",
   priority = 1000,
   config = true,
   opts = {
    rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" }
   }
  },
  -- {
  -- "rest-nvim/rest.nvim",
  --  rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
  --  config = function()
  --    require("rest-nvim").setup()
  --  end,
  -- },
  {
    "David-Kunz/cmp-npm",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    ft = "json",
    config = function()
     require('cmp-npm').setup({})
    end
  },
  {
    "vuki656/package-info.nvim",
    as = "package-info",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup {
        package_manager = "npm",
      }
    end,
  },
  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets/angular", "./snippets/ionic" } }
    end,
  },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  "max397574/better-escape.nvim",

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
}

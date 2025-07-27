-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = true,
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    'jay-babu/mason-null-ls.nvim',
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
    end,
  },
}

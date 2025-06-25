return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        overrides = function(colors)
          return {
            -- Custom TS highlights
            ['@lsp.type.interface'] = { fg = '#0AA703', italic = true },
            -- ['@lsp.type.method.typescript'] = { fg = '#FFC66D', italic = true },
          }
        end,
      }
      -- Встановити тему
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}

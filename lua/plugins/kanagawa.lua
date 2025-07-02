return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        overrides = function(colors)
          local palette = colors.palette
          return {
            -- 🔷 Const
            ['@constant'] = { fg = '#B13939', bold = true },
            ['@lsp.mod.constant'] = { fg = '#B13939', bold = true },
            ['@lsp.typemod.variable.readonly'] = { fg = '#B13939', bold = true },
            ['@lsp.typemod.property.readonly'] = { fg = '#9876AA' },

            -- 🔵 Variables
            ['@variable'] = { fg = palette.crystalBlue },
            ['@lsp.type.variable'] = { fg = palette.crystalBlue },
            ['@lsp.type.variable.readonly'] = { fg = palette.crystalBlue },
            ['@lsp.type.property'] = { fg = '#9876AA' },
            ['@lsp.type.enumMember'] = { fg = '#9876AA' },
            ['@lsp.typemod.enumMember.readonly'] = { fg = '#9876AA' },

            --  Types
            ['@type.builtin'] = { fg = '#CC7832' },

            -- 🟣 Class
            ['@lsp.type.class'] = { fg = '#729BFF' },
            ['@lsp.type.interface'] = { fg = '#0AA703', italic = true },
            ['@lsp.type.type'] = { fg = palette.springBlue },

            -- 🟠 Properties
            ['@lsp.mod.property'] = { fg = '#9876AA' },
            ['@lsp.mod.local'] = { fg = '#A9B7C6' },

            -- 🔵 Functions
            ['@lsp.type.method'] = { fg = '#FFC66D' },
            ['@lsp.type.function'] = { fg = '#6DFAFF' },
            ['@function.call'] = { fg = '#6DFAFF' },

            -- 🔤 primitives
            ['@string'] = { fg = '#5A8759' },
            ['@number'] = { fg = '#5897BB' },
            ['@comment'] = { fg = palette.fujiGray, italic = true },

            -- 🧩  keywords
            ['@keyword'] = { fg = '#CC7832' },
            ['typescriptPredefinedType'] = { fg = '#CC7832' },
            ['@modifier'] = { fg = '#CC7832' },
            ['@keyword.import'] = { fg = '#CC7832' },
            ['@keyword.return'] = { fg = '#CC7832' },
            ['@signal_definition'] = { fg = '#a6e22e', bold = true },
            ['@signal_effect'] = { fg = '#fd971f', italic = true },
          }
        end,
      }
      -- theme install
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}

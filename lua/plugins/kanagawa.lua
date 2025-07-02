return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup {
        overrides = function(colors)
          local palette = colors.palette
          return {
            -- 🔷 Константи (WebStorm-style): насичений оранжево-жовтий
            ['@constant'] = { fg = '#B13939', bold = true },
            ['@lsp.mod.constant'] = { fg = '#B13939', bold = true },

            -- 🔵 Змінні: світло-блакитні
            ['@variable'] = { fg = palette.crystalBlue },
            ['@lsp.type.variable'] = { fg = palette.crystalBlue },
            ['@lsp.type.property'] = { fg = '#9876AA' },
            ['@lsp.typemod.property.readonly'] = { fg = '#9876AA' },
            ['@lsp.type.enumMember'] = { fg = '#9876AA' },
            ['@lsp.typemod.enumMember.readonly'] = { fg = '#9876AA' },

            -- 🔹 Вбудовані змінні (`window`, `console`): менш яскраві, курсивом
            ['@type.builtin'] = { fg = '#CC7832' },

            -- 🟣 Типи (тип змінної, класу, інтерфейсу)
            ['@type'] = { fg = palette.springBlue },
            ['@lsp.type.class'] = { fg = '#729BFF' },
            ['@lsp.type.interface'] = { fg = '#0AA703', italic = true },
            ['@lsp.type.type'] = { fg = palette.springBlue },

            -- 🟠 Властивості об'єктів
            ['@lsp.mod.property'] = { fg = '#9876AA' },
            ['@lsp.mod.local'] = { fg = '#A9B7C6' },

            -- 🔵 Методи / функції
            ['@lsp.type.method'] = { fg = '#FFC66D' },
            ['@lsp.type.function'] = { fg = '#6DFAFF' },
            ['@function.call'] = { fg = '#6DFAFF' },

            -- 🔤 Рядки, числа, коментарі
            ['@string'] = { fg = '#5A8759' },
            ['@number'] = { fg = '#5897BB' },
            ['@comment'] = { fg = palette.fujiGray, italic = true },

            -- 🧩 Ключові слова
            ['@keyword'] = { fg = '#CC7832' },
            ['@keyword.import'] = { fg = '#CC7832' },
            ['@keyword.return'] = { fg = '#CC7832' },
            ['@signal_definition'] = { fg = '#a6e22e', bold = true },
            ['@signal_effect'] = { fg = '#fd971f', italic = true },
            -- return {
            --   -- Custom TS highlights
            --   ['@lsp.type.interface'] = { fg = '#0AA703', italic = true },
            --   ['@constant.typescript'] = { fg = '#B13939', italic = true, bold = true },
            --   ['@lsp.type.property.typescript'] = { fg = '#9876AA' },
            --   -- ['@lsp.mod.readonly.typescript links to Constant'] = { fg = '#B13939', italic = true, bold = true },
            --   -- ['@lsp.type.method.typescript'] = { fg = '#FFC66D', italic = true },
          }
        end,
      }
      -- Встановити тему
      vim.cmd.colorscheme 'kanagawa'
    end,
  },
}

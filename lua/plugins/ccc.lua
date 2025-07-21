return {
  'uga-rosa/ccc.nvim',
  enable = true,
  autoLoad = true,
  event = 'BufReadPost',
  config = function()
    local ccc = require 'ccc'
    ccc.setup {
      highlighter = {
        auto_enable = true,
        lsp = true,
        filetypes = {'css', 'scss'}
      },
    }

    vim.keymap.set('n', '<leader>Cp', '<cmd>CccPick<cr>', { desc = '🎨 Color Picker' })
    vim.keymap.set('n', '<leader>Cc', '<cmd>CccConvert<cr>', { desc = '🔁 Convert Color' })
  end,
  cmd = { 'CccPick', 'CccConvert' },
}

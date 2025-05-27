return {
  'echasnovski/mini.nvim',
  version = '*',
  config = function()
    vim.keymap.set('n', '<leader>bc', function()
      require('mini.bufremove').delete(0, false)
    end, { desc = 'Close buffer' })
  end,
}

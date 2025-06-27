return {
  {
    'vuki656/package-info.nvim',
    dependencies = { 'MunifTanjim/nui.nvim' },
    ft = 'json', -- або `lazy = true` якщо використовуєш LazyVim
    keys = {
      {
        '<leader>ns',
        "<cmd>lua require('package-info').show()<cr>",
        silent = true,
        noremap = true,
        desc = 'Show Package Info',
      },
    },
    config = function()
      require('package-info').setup()
    end,
  },
}

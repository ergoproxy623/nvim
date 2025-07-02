return {
  {
    'Sewb21/nx.nvim',

    dependencies = {
      'nvim-telescope/telescope.nvim',
    },

    opts = {
      -- See below for config options
      nx_cmd_root = 'npx nx',
    },

    -- Plugin will load when you use these keys
    keys = {
      { '<leader>sA', '<cmd>Telescope nx actions<CR>', desc = 'nx actions' },
      { '<leader>sG', '<cmd>Telescope nx generators<CR>', desc = 'nx generators' },
    },
  },
}

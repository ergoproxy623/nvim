return {
  'rcarriga/nvim-notify',
  lazy = true,
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<Leader>uD',
      function()
        require('notify').dismiss { pending = true, silent = true }
      end,
      desc = 'Dismiss notifications',
    },
  },
  opts = {
    icons = {
      DEBUG = '',
      ERROR = '',
      INFO = '',
      TRACE = '✎',
      WARN = '',
    },
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 175 })
      vim.wo[win].conceallevel = 3
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, 'markdown') then
        vim.bo[buf].syntax = 'markdown'
      end
      vim.wo[win].spell = false
    end,
  },
  config = function(_, opts)
    require('notify').setup(opts)
    vim.notify = require 'notify'
  end,
}

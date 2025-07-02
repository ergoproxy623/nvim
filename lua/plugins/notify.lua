return {
  'rcarriga/nvim-notify',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>un',
      function()
        require('notify').dismiss { silent = true, pending = true }
      end,
      desc = 'Clear all',
    },
    {
      '<leader>sn',
      '<cmd>Telescope notify<cr>',
      desc = 'History',
    },
  },
  opts = {
    stages = 'fade', -- або "static", "slide", "fade_in_slide_out"
    timeout = 2000,
    max_width = 80,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    background_colour = '#000000',
    render = 'default', -- або minimal, wrapped-compact
    fps = 60,
  },
  config = function(_, opts)
    local notify = require 'notify'
    notify.setup(opts)

    --- Переопреділення vim.notify з фільтром
    vim.notify = function(msg, level, user_opts)
      if type(msg) == 'string' then
        local lowered = msg:lower()
        if lowered:match 'diagnostic' or lowered:match 'lsp' or lowered:match 'language server' then
          return
        end
      end
      notify(msg, level, user_opts)
    end
  end,
}

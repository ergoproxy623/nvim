local term = vim.trim((vim.env.TERM_PROGRAM or ''):lower())
local mux = term == 'tmux' or term == 'wezterm' or vim.env.KITTY_LISTEN_ON

return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  event = mux and 'VeryLazy' or nil, -- load early if mux detected
  opts = {
    ignored_filetypes = { 'nofile', 'quickfix', 'qf', 'prompt' },
    ignored_buftypes = { 'nofile' },
  },
  config = function()
    -- Key mappings for smart-splits
    local maps = {
      n = {
        ['<C-H>'] = {
          function()
            require('smart-splits').move_cursor_left()
          end,
          desc = 'Move to left split',
        },
        ['<C-J>'] = {
          function()
            require('smart-splits').move_cursor_down()
          end,
          desc = 'Move to below split',
        },
        ['<C-K>'] = {
          function()
            require('smart-splits').move_cursor_up()
          end,
          desc = 'Move to above split',
        },
        ['<C-L>'] = {
          function()
            require('smart-splits').move_cursor_right()
          end,
          desc = 'Move to right split',
        },
        ['<C-Up>'] = {
          function()
            require('smart-splits').resize_up()
          end,
          desc = 'Resize split up',
        },
        ['<C-Down>'] = {
          function()
            require('smart-splits').resize_down()
          end,
          desc = 'Resize split down',
        },
        ['<C-Left>'] = {
          function()
            require('smart-splits').resize_left()
          end,
          desc = 'Resize split left',
        },
        ['<C-Right>'] = {
          function()
            require('smart-splits').resize_right()
          end,
          desc = 'Resize split right',
        },
      },
    }

    for mode, keymap in pairs(maps) do
      for lhs, rhs in pairs(keymap) do
        vim.keymap.set(mode, lhs, rhs[1], { desc = rhs.desc })
      end
    end
  end,
}

return {
  'numToStr/Comment.nvim',
  dependencies = {
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  event = 'VeryLazy',
  keys = {
    {
      '<Leader>/',
      function()
        return require('Comment.api').call('toggle.linewise.' .. (vim.v.count == 0 and 'current' or 'count_repeat'), 'g@$')()
      end,
      expr = true,
      silent = true,
      desc = 'Toggle comment line',
      mode = 'n',
    },
    {
      '<Leader>/',
      "<Esc><Cmd>lua require('Comment.api').locked('toggle.linewise')(vim.fn.visualmode())<CR>",
      desc = 'Toggle comment',
      mode = 'x',
    },
  },
  opts = function()
    local opts = {}
    local ok, commentstring = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
    if ok then
      opts.pre_hook = commentstring.create_pre_hook()
    end
    return opts
  end,
}

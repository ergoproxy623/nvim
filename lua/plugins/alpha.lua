return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.api.nvim_create_autocmd('BufDelete', {
      callback = function()
        local bufs = vim.fn.getbufinfo { buflisted = 1 }
        local normal_bufs = vim.tbl_filter(function(buf)
          local ft = vim.bo[buf.bufnr].filetype
          return ft ~= 'neo-tree' and ft ~= 'alpha' and buf.name ~= '' and buf.loaded == 1
        end, bufs)

        if #normal_bufs == 0 then
          pcall(vim.cmd, 'Neotree close')
          vim.cmd 'Alpha'
        end
      end,
    })
    local startify = require 'alpha.themes.startify'
    startify.file_icons.provider = 'devicons'
    require('alpha').setup(startify.config)
    require 'config.alpha'
  end,
  event = 'VimEnter',
}

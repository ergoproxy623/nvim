return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    vim.api.nvim_create_autocmd('BufDelete', {
      callback = function()
        -- Збираємо список активних буферів, ігноруючи Neo-tree та Alpha
        local bufs = vim.fn.getbufinfo { buflisted = 1 }
        local normal_bufs = vim.tbl_filter(function(buf)
          local ft = vim.bo[buf.bufnr].filetype
          return ft ~= 'neo-tree' and ft ~= 'alpha' and buf.name ~= '' and buf.loaded == 1
        end, bufs)

        if #normal_bufs == 0 then
          -- Закриваємо Neo-tree перед відкриттям Alpha
          pcall(vim.cmd, 'Neotree close')
          vim.cmd 'Alpha'
        end
      end,
    })
    local startify = require 'alpha.themes.startify'
    -- available: devicons, mini, default is mini
    -- if provider not loaded and enabled is true, it will try to use another provider
    startify.file_icons.provider = 'devicons'
    require('alpha').setup(startify.config)
    require 'config.alpha'
  end,
  event = 'VimEnter',
}

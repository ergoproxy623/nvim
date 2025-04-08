return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require 'config.alpha' -- конфіг в окремому файлі
  end,
  event = 'VimEnter',
}

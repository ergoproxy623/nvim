return {
  'dstein64/nvim-scrollview',
  config = function()
    require('scrollview').setup {
      excluded_filetypes = { 'neo-tree', 'lazygit', 'terminal' },
      signs_on_startup = { 'all' }, -- або 'gitsigns'
    }
  end,
}

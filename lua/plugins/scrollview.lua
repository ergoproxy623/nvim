return {
  'dstein64/nvim-scrollview',
  config = function()
    require('scrollview').setup {
      excluded_filetypes = { "NvimTree", "neo-tree", "lazy", "TelescopePrompt" },
      signs_on_startup = { 'all' }, -- або 'gitsigns'
    }
  end,
}

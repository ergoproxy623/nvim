return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    -- Will use Telescope if installed or a vim.ui.select picker otherwise
    { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
    { '<leader>ww', '<cmd>SessionSave<CR>', desc = 'Save session' },
    { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
  },
  config = function()
    require('auto-session').setup {
      pre_save_cmds = {
        'tabdo Neotree close', -- Close Neotree before saving session
      },
      post_restore_cmds = {
        'Neotree', -- Open Neotree
        function()
          vim.cmd.redrawtabline()
        end,
      },
      auto_restore = false,
      use_git_branch = true,
      bypass_save_filetypes = { 'alpha', 'dashboard' }, -- or whatever dashboard you use
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      session_lens = {
        load_on_setup = true, -- Initialize on startup (requires Telescope)
        previewer = false, -- File preview for session picker
        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { 'i', '<C-D>' },
          alternate_session = { 'i', '<C-S>' },
          copy_session = { 'i', '<C-Y>' },
        },

        session_control = {
          control_dir = vim.fn.stdpath 'data' .. '/auto_session/', -- Auto session control dir, for control files, like alternating between two sessions with session-lens
          control_filename = 'session_control.json', -- File name of the session control file
        },
      },
    }
  end,
}

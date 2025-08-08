return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local custom = require 'tools.npm-run-list'
    local nx = require 'tools.nx-list'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search Keymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search Files' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Search Select Telescope' })
    vim.keymap.set('n', '<leader>sW', builtin.grep_string, { desc = 'Search current Word' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Grep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search Diagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = 'Search Resume' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>rn', function()
      custom.run_npm_script()
    end, { desc = 'Search Npm Run' })
    vim.keymap.set('n', '<leader>rx', function()
      nx.run()
    end, { desc = 'Search Nx Run' })
    vim.keymap.set('n', '<leader>q', function()
      vim.cmd 'wqa'
    end, { desc = 'Exit' })
    local pickers = require 'telescope.pickers'
    local finders = require 'telescope.finders'
    local conf = require('telescope.config').values
    local builtin = require 'telescope.builtin'

    local filetypes = {
      { name = 'TypeScript', globs = { '*.ts' } },
      { name = 'HTML', globs = { '*.html' } },
      { name = 'CSS', globs = { '*.css' } },
      { name = 'SASS/SCSS', globs = { '*.sass', '*.scss' } },
    }

    vim.keymap.set('n', '<leader>stf', function()
      pickers
        .new({}, {
          prompt_title = 'Choose filetype for grep',
          finder = finders.new_table {
            results = filetypes,
            entry_maker = function(entry)
              return {
                value = entry.globs,
                display = entry.name,
                ordinal = entry.name,
              }
            end,
          },
          sorter = conf.generic_sorter {},
          attach_mappings = function(_, map)
            map('i', '<CR>', function(prompt_bufnr)
              local actions = require 'telescope.actions'
              local state = require 'telescope.actions.state'
              local selection = state.get_selected_entry()
              actions.close(prompt_bufnr)

              builtin.live_grep {
                prompt_title = 'Grep in ' .. selection.display,
                additional_args = function()
                  local args = {}
                  for _, glob in ipairs(selection.value) do
                    table.insert(args, '--glob=' .. glob)
                  end
                  return args
                end,
              }
            end)
            return true
          end,
        })
        :find()
    end, { desc = 'Live grep by filetype (dropdown)' })

    -- Slightly advanced example of overriding default behavior and theme
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    -- Shortcut for searching your Neovim configuration files
  end,
}

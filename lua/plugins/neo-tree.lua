-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = { 'MunifTanjim/nui.nvim', 'kyazdani42/nvim-web-devicons', 'nvim-lua/plenary.nvim' },
  config = function()
    local devicons = require 'nvim-web-devicons'
    require('neo-tree').setup {
      close_if_last_window = true,
      enable_git_status = true,
      enable_diagnostics = true,
      default_component_configs = {
        indent = {
          padding = 1,
          with_markers = true,
        },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
          folder_empty_open = '',
          default = '',
        },
        modified = {
          symbol = '',
          highlight = 'NeoTreeModified',
        },
        git_status = {
          symbols = {
            added = '',
            modified = '',
            deleted = '',
            renamed = '➜',
            untracked = '★',
            ignored = '◌',
            unstaged = '✗',
            staged = '✓',
            conflict = '',
          },
        },
        file_icon = {
          enabled = true,
          provider = function(filename)
            local icon, color = devicons.get_icon_color(filename, nil, { default = true })
            return icon, color
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        position = 'left',
        width = 30,
        mappings = {
          ['<CR>'] = 'open',
          ['o'] = 'open',
          ['s'] = 'open_split',
          ['v'] = 'open_vsplit',
          ['C'] = 'close_node',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
        },
      },
      sources = {
        'filesystem',
        'buffers',
        'git_status',
      },
      source_selector = {
        winbar = true,
        statusline = false,
        sources = {
          { source = 'filesystem', display_name = '  Files ' },
          { source = 'buffers', display_name = '  Buffers ' },
          { source = 'git_status', display_name = '  Git ' },
        },
      },
      tabs = {
        active = true,
        separator = ' │ ',
        symbols = {
          filesystem = '',
          buffers = '',
          git_status = '',
        },
        sort_function = function(a, b)
          -- Simplified check if a path is in the 'notes' directory
          local function is_in_notes_directory(path)
            return string.match(path, '/notes/') or string.match(path, '^notes/')
          end

          -- Get the modification time of a file
          local function get_mod_time(path)
            local attributes = vim.loop.fs_stat(path)
            return attributes and attributes.mtime.sec or 0
          end

          -- Prioritize directories over files
          if a.type ~= b.type then
            return a.type == 'directory'
          end

          local a_in_notes = is_in_notes_directory(a.path)
          local b_in_notes = is_in_notes_directory(b.path)

          -- If both nodes are files in 'notes' directories, sort by modification time
          if a_in_notes and b_in_notes and a.type ~= 'directory' and b.type ~= 'directory' then
            return get_mod_time(a.path) > get_mod_time(b.path)
          end

          -- Default sort by name, assuming `name` property or similar is available
          -- You might need to extract the name from `a.path` and `b.path` if direct comparison is needed
          local a_name = a.path:match '^.+/(.+)$' or a.path
          local b_name = b.path:match '^.+/(.+)$' or b.path
          return a_name < b_name
        end,
      },
    }
  end,
}

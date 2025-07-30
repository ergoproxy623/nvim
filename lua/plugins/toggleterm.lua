return {
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  lazy = false,
  opts = {
    highlights = {
      Normal = { link = 'Normal' },
      NormalNC = { link = 'NormalNC' },
      NormalFloat = { link = 'NormalFloat' },
      FloatBorder = { link = 'FloatBorder' },
      StatusLine = { link = 'StatusLine' },
      StatusLineNC = { link = 'StatusLineNC' },
      WinBar = { link = 'WinBar' },
      WinBarNC = { link = 'WinBarNC' },
    },
    size = 10,
    shading_factor = 2,
    float_opts = { border = 'rounded' },
    on_create = function(t)
      vim.opt_local.foldcolumn = '0'
      vim.opt_local.signcolumn = 'no'
      if t.hidden then
        local function toggle()
          t:toggle()
        end
        vim.keymap.set({ 'n', 't', 'i' }, "<C-'>", toggle, { desc = 'Toggle terminal', buffer = t.bufnr })
        vim.keymap.set({ 'n', 't', 'i' }, '<F7>', toggle, { desc = 'Toggle terminal', buffer = t.bufnr })
      end
    end,
  },
  config = function()
    require('toggleterm').setup {
      size = function(term)
        if term.direction == 'horizontal' then
          return 15
        elseif term.direction == 'vertical' then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      shade_filetypes = {},
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
      direction = 'float',
      float_opts = {
        border = 'curved',
        winblend = 0,
      },
    }

    local keymaps = {
      ['<Leader>tf'] = { '<Cmd>ToggleTerm direction=float<CR>', desc = 'ToggleTerm float' },
      ['<Leader>th'] = { '<Cmd>ToggleTerm size=10 direction=horizontal<CR>', desc = 'ToggleTerm horizontal split' },
      ['<Leader>tv'] = { '<Cmd>ToggleTerm size=80 direction=vertical<CR>', desc = 'ToggleTerm vertical split' },
      ['<F7>'] = { '<Cmd>ToggleTerm<CR>', desc = 'Toggle terminal' },
      ["<C-'>"] = { '<Cmd>ToggleTerm<CR>', desc = 'Toggle terminal' },
    }

    if vim.fn.executable 'lazygit' == 1 then
      local Terminal = require('toggleterm.terminal').Terminal

      local function current_file_path()
        return vim.fn.expand '%:p'
      end

      local lazygit_history = Terminal:new {
        cmd = 'lazygit log ' .. current_file_path(),
        hidden = true,
        direction = 'float',
        float_opts = {
          border = 'double',
        },
      }

      local function toggle_term_cmd(cmd)
        local term = Terminal:new {
          cmd = cmd,
          hidden = true,
          direction = 'float',
          float_opts = {
            border = 'double',
          },
        }
        term:toggle()
      end

      keymaps['<Leader>gg'] = {
        function()
          toggle_term_cmd 'lazygit'
        end,
        desc = 'ToggleTerm lazygit',
      }

      keymaps['<Leader>tl'] = keymaps['<Leader>gg']

      keymaps['<Leader>tH'] = {
        function()
          lazygit_history:toggle()
        end,
        desc = 'LazyGit History (file)',
      }
    end
    if vim.fn.executable 'node' == 1 then
      keymaps['<Leader>tn'] = {
        function()
          toggle_term_cmd 'node'
        end,
        desc = 'ToggleTerm node',
      }
    end
    if vim.fn.executable 'btm' == 1 then
      keymaps['<Leader>tt'] = {
        function()
          toggle_term_cmd 'btm'
        end,
        desc = 'ToggleTerm btm',
      }
    end
    local python = vim.fn.executable 'python' == 1 and 'python' or vim.fn.executable 'python3' == 1 and 'python3'
    if python then
      keymaps['<Leader>tp'] = {
        function()
          toggle_term_cmd(python)
        end,
        desc = 'ToggleTerm python',
      }
    end

    for k, v in pairs(keymaps) do
      vim.keymap.set('n', k, v[1], { desc = v.desc })
    end
  end,
}

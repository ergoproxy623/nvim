-- lua/plugins/npm-run-list.lua

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local M = {}

function M.run_npm_script()
  local file = io.open('package.json', 'r')
  if not file then
    vim.notify('No package.json found', vim.log.levels.ERROR)
    return
  end
  local content = file:read '*a'
  file:close()

  local ok, data = pcall(vim.fn.json_decode, content)
  if not ok or not data.scripts then
    vim.notify('No scripts found in package.json', vim.log.levels.ERROR)
    return
  end

  local scripts = vim.tbl_keys(data.scripts)
  table.sort(scripts)

  pickers
    .new({}, {
      prompt_title = 'npm run',
      finder = finders.new_table { results = scripts },
      sorter = conf.generic_sorter {},
      attach_mappings = function(_, map)
        actions.select_default:replace(function(prompt_bufnr)
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local Terminal = require('toggleterm.terminal').Terminal

          if selection then
            local cmd = 'npm run ' .. selection[1]
            local term = Terminal:new {
              cmd = cmd,
              direction = 'vertical',
              size = 80,
              hidden = true,
              close_on_exit = false,
            }
            term:toggle()
          end
        end)
        return true
      end,
    })
    :find()
end

return M

local uv = vim.loop
local M = {}

local has_telescope, telescope = pcall(require, 'telescope')
if not has_telescope then
  vim.notify('Telescope not found', vim.log.levels.ERROR)
  return M
end

local pickers = require 'telescope.pickers'
local finders = require 'telescope.finders'
local conf = require('telescope.config').values
local actions = require 'telescope.actions'
local action_state = require 'telescope.actions.state'

local function read_json_file(path)
  local f = io.open(path, 'r')
  if not f then
    return nil
  end
  local content = f:read '*a'
  f:close()
  local ok, data = pcall(vim.fn.json_decode, content)
  if not ok then
    return nil
  end
  return data
end

local function find_project_json_files(root)
  local results = {}

  local function scan_dir(dir)
    local fd = uv.fs_opendir(dir, nil, 100)
    if not fd then
      return
    end

    while true do
      local entries = uv.fs_readdir(fd)
      if not entries then
        break
      end

      for _, entry in ipairs(entries) do
        local full_path = dir .. '/' .. entry.name
        if entry.type == 'file' and entry.name == 'project.json' then
          table.insert(results, full_path)
        elseif entry.type == 'directory' then
          if not entry.name:match '^node_modules$' and not entry.name:match '^dist$' and not entry.name:match '^%.git$' then
            scan_dir(full_path)
          end
        end
      end
    end
    uv.fs_closedir(fd)
  end

  scan_dir(root)
  return results
end

local function get_project_name(project_path)
  local path_parts = vim.split(project_path, '/')
  return path_parts[#path_parts - 1] or 'unknown'
end

local function get_nx_commands()
  local cwd = uv.cwd()
  local results = {}

  -- Спроба прочитати workspace.json
  local workspace_path = cwd .. '/workspace.json'
  local data = read_json_file(workspace_path)

  if data and data.projects then
    for project_name, project_data in pairs(data.projects) do
      if project_data.targets then
        for target_name, target_data in pairs(project_data.targets) do
          -- базовий target
          table.insert(results, project_name .. ':' .. target_name)
          -- якщо є configurations
          if target_data.configurations then
            for config_name, _ in pairs(target_data.configurations) do
              table.insert(results, project_name .. ':' .. target_name .. ':' .. config_name)
            end
          end
        end
      end
    end
  end

  -- Тепер додаємо всі project.json
  for _, path in ipairs(find_project_json_files(cwd)) do
    local json = read_json_file(path)
    if json and json.targets then
      local project_name = json.name or get_project_name(path)
      for target_name, target_data in pairs(json.targets) do
        table.insert(results, project_name .. ':' .. target_name)
        if target_data.configurations then
          for config_name, _ in pairs(target_data.configurations) do
            table.insert(results, project_name .. ':' .. target_name .. ':' .. config_name)
          end
        end
      end
    end
  end

  return results
end

function M.run()
  pickers
    .new({}, {
      prompt_title = 'Nx Commands',
      finder = finders.new_table {
        results = get_nx_commands(),
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          local Terminal = require('toggleterm.terminal').Terminal

          if selection then
            local cmd = 'npx nx run ' .. selection[1]
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

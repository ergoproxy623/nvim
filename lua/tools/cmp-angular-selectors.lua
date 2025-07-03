local source = {}
local selectors = {}
local scanned = false
local refreshing = false

local M = {}

-- Асинхронне читання одного файлу
local function read_file_async(path, on_read)
  vim.loop.fs_open(path, 'r', 438, function(err_open, fd)
    if err_open or not fd then
      return
    end
    vim.loop.fs_fstat(fd, function(_, stat)
      if not stat or stat.size == 0 then
        vim.loop.fs_close(fd)
        return
      end
      vim.loop.fs_read(fd, stat.size, 0, function(_, data)
        vim.loop.fs_close(fd)
        if data then
          on_read(data)
        end
      end)
    end)
  end)
end

-- Асинхронний рекурсивний скан директорій
local function scan_dir_async(dir, on_done)
  local uv = vim.loop
  local pending = 0
  local done = false

  local function scan(path)
    pending = pending + 1
    local fs = uv.fs_scandir(path)
    if not fs then
      pending = pending - 1
      return
    end

    while true do
      local name, t = uv.fs_scandir_next(fs)
      if not name then
        break
      end

      local full_path = path .. '/' .. name
      if t == 'file' and name:match '%.component%.ts$' then
        pending = pending + 1
        read_file_async(full_path, function(content)
          for line in content:gmatch '[^\r\n]+' do
            local selector = line:match 'selector:%s*[\'"]([%w%-]+)[\'"]'
            if selector then
              table.insert(selectors, selector)
            end
          end
          pending = pending - 1
          if pending == 0 and not done then
            done = true
            on_done()
          end
        end)
      elseif t == 'directory' and name ~= 'node_modules' then
        scan(full_path)
      end
    end

    pending = pending - 1
    if pending == 0 and not done then
      done = true
      on_done()
    end
  end

  scan(dir)
end

-- Публічна функція для оновлення селекторів
function M.refresh()
  if refreshing then
    return
  end
  refreshing = true
  scanned = false
  selectors = {}

  scan_dir_async(vim.fn.getcwd(), function()
    refreshing = false
    scanned = true
    vim.schedule(function()
      vim.notify('Angular selectors refreshed (async)', vim.log.levels.INFO)
    end)
  end)
end

-- CMP API
function source:is_available()
  return true
end

function source:complete(_, callback)
  if not scanned then
    M.refresh()
  end

  local items = {}
  for _, sel in ipairs(selectors) do
    table.insert(items, {
      label = sel,
      kind = vim.lsp.protocol.CompletionItemKind.Class,
      detail = 'Angular Selector',
    })
  end

  callback { items = items, isIncomplete = false }
end

return setmetatable(source, { __index = M })

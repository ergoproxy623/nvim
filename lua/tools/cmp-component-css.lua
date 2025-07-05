local source = {}
local classes = {}
local scanned_file = nil

local M = {}

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

local function extract_classes(content)
  local results = {}
  for class in content:gmatch '%.[%w%-_]+' do
    table.insert(results, class:sub(2)) -- без крапки
  end
  return results
end

-- Публічна функція для оновлення з SCSS
function M.refresh_for_html(html_path)
  local style_extensions = { 'scss', 'sass', 'css' }

  local base_path = html_path:gsub('%.html$', '')
  local found = false

  for _, ext in ipairs(style_extensions) do
    local style_path = base_path .. '.' .. ext
    if vim.fn.filereadable(style_path) == 1 then
      found = true
      read_file_async(style_path, function(content)
        classes = extract_classes(content)
        scanned_file = style_path
        vim.schedule(function()
          vim.notify('CSS classes refreshed from ' .. vim.fn.fnamemodify(style_path, ':t'), vim.log.levels.INFO)
        end)
      end)
      break -- беремо перший знайдений
    end
  end

  if not found then
    classes = {}
    scanned_file = nil
  end
end

--  source available
function source:is_available()
  return true
end

function source:complete(_, callback)
  local items = {}
  for _, class in ipairs(classes) do
    table.insert(items, {
      label = class,
      kind = vim.lsp.protocol.CompletionItemKind.Class,
      detail = 'SCSS Class (' .. (scanned_file or '?') .. ')',
    })
  end
  callback { items = items, isIncomplete = false }
end

return setmetatable(source, { __index = M })

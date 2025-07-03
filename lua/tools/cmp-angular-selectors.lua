local source = {}
local selectors = {}
local scanned = false

local M = {}

-- Рекурсивний пошук по файловій системі для .component.ts
local function scan_for_selectors(root)
  selectors = {}
  local uv = vim.loop

  local function scan_dir(dir)
    for name, type in vim.fs.dir(dir) do
      local full_path = dir .. '/' .. name
      if type == 'file' and name:match '%.component%.ts$' then
        for line in io.lines(full_path) do
          local selector = line:match 'selector:%s*["\']([%w%-]+)["\']'
          if selector then
            table.insert(selectors, selector)
          end
        end
      elseif type == 'directory' and name ~= 'node_modules' then
        scan_dir(full_path)
      end
    end
  end

  scan_dir(root)
  scanned = true
end

-- Публічна функція для оновлення
function M.refresh()
  scanned = false
  scan_for_selectors(vim.fn.getcwd())
end

function source:is_available()
  return true
end

function source:complete(_, callback)
  if not scanned then
    scan_for_selectors(vim.fn.getcwd())
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

return setmetatable(source, {
  __index = M, -- додає refresh() як метод до модуля
})

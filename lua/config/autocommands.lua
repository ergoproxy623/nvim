local group = vim.api.nvim_create_augroup('autosave_like_webstorm', { clear = true })

local function format_and_save()
  if vim.bo.modified and vim.bo.buftype == '' and not vim.bo.readonly then
    local ok = pcall(function()
      require('conform').format { bufnr = 0, async = false }
    end)
    if not ok then
      vim.notify('⚠️ Conform not available or formatting failed', vim.log.levels.WARN)
    end
    vim.cmd 'silent! write'
  end
end

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*.component.html',
  callback = function()
    require('tools.cmp-angular-selectors').refresh()
  end,
})

local css = require 'tools.cmp-component-css'
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*.component.html',
  callback = function(args)
    css.refresh_for_html(args.file)
  end,
})

vim.api.nvim_create_user_command('CmpScssRefresh', function()
  local file = vim.api.nvim_buf_get_name(0)
  css.refresh_for_html(file)
end, {})

vim.api.nvim_create_user_command('FindCssClass', function()
  require('tools.go-to-css').find_class_definition()
end, {})

vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
  group = group,
  callback = format_and_save,
})

-- vim.api.nvim_create_autocmd('CursorHoldI', {
--   group = group,
--   callback = save, --some handler
-- })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ 'TermClose', 'BufWritePost' }, {
  pattern = '*',
  callback = function()
    require('neo-tree.sources.manager').refresh 'filesystem'
  end,
})

local M = {}

local function get_word_under_cursor()
  local word = vim.fn.expand '<cword>'
  return word or ''
end

function M.find_class_definition()
  local class_name = get_word_under_cursor()
  if not class_name or class_name == '' then
    vim.notify('No class name under cursor', vim.log.levels.WARN)
    return
  end

  local rg_query = '%.' .. class_name .. '%s*[{,]'

  require('telescope.builtin').grep_string {
    prompt_title = 'CSS class: .' .. class_name,
    search = rg_query,
    glob_pattern = { '**/*.scss', '**/*.sass', '**/*.css' },
    use_regex = true,
  }
end

return M

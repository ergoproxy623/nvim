vim.filetype.add({
  pattern = {
    [".*%.component%.html"] = "angularhtml", -- Sets the filetype to `angularhtml` if it matches the pattern
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "angularhtml",
  callback = function()
    vim.treesitter.language.register("angular", "angularhtml") -- Register the filetype with treesitter for the `angular` language/parser
  end,
})

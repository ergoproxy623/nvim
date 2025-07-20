return {
  "uga-rosa/ccc.nvim",
  config = function()
    local ccc = require("ccc")
    ccc.setup({
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    })

    vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<cr>", { desc = "🎨 Color Picker" })
    vim.keymap.set("n", "<leader>ce", "<cmd>CccConvert<cr>", { desc = "🔁 Convert Color" })
  end,
  cmd = { "CccPick", "CccConvert" },
}

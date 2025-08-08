-- ~/.config/nvim/lua/plugins/neotest.lua

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "haydenmeade/neotest-jest",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-jest")({
          jestCommand = "npm test --", -- або "ng test --" якщо використовуєш Angular CLI напряму
          jestConfigFile = "jest.config.js", -- або "jest.config.ts" якщо в тебе TypeScript
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })
  end,
}


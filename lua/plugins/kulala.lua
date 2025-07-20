return {
  "mistweaverco/kulala.nvim",
  ft = { "http" },
  keys = {
    { '<leader>Rs', desc = 'Send request' },
    { '<leader>Ra', desc = 'Send all requests' },
    { '<leader>Rb', desc = 'Open scratchpad' },
  },
  opts = {
    global_keymaps = false,
    kulala_keymaps_prefix = "",

    -- Scratchpad у vertical split
    scratchpad = {
      enabled = true,
      open = function()
        vim.cmd("vsplit")
        vim.cmd("KulalaScratch")
      end,
    },

    -- Директорія для .http файлів
    storage = {
      save_requests = true,
      directory = vim.fn.stdpath("config") .. "/http_requests",
    },

    -- Відкривати відповіді в vertical split
    response_window = {
      open = function()
        vim.cmd("vsplit")
      end,
    },
  },
}


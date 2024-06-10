

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "lua_ls",
        -- add more arguments for adding more language servers
      })
    end,
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = function(_, opts)
      -- add more things to the ensure_installed table protecting against community packs modifying it
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        -- add more arguments for adding more null-ls sources
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mxsdev/nvim-dap-vscode-js",
      -- build debugger from source
      {
        "microsoft/vscode-js-debug",
        version = "1.*",
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
      }
    },
    config = function()
      require("dap-vscode-js").setup({
       debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
         adapters = {
              "chrome",
              "pwa-node",
              "pwa-chrome",
              "pwa-msedge",
              "pwa-extensionHost",
              "node-terminal",
            },
      })
  
    for _, language in ipairs({ "typescript", "javascript" }) do
        require("dap").configurations[language] = {
          
          {
            type = "pwa-chrome",
            name = "Launch Chrome to debug client",
            request = "launch",
            url = "http://localhost:4200",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/src",
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },
          -- only if language is javascript, offer this debug action
          language == "javascript" and {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = "pwa-node",
            -- launch a new process to attach the debugger to
            request = "launch",
            -- name of the debug action you have to select for this config
            name = "Launch file in new node process",
            -- launch current file
            program = "${file}",
            cwd = "${workspaceFolder}",
          } or nil,
        }
      end
  
      require("dapui").setup()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({ reset = true })
      end
      dap.listeners.before.event_terminated["dapui_config"] = dapui.close
      dap.listeners.before.event_exited["dapui_config"] = dapui.close
    end
  },
}

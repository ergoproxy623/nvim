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
        "lua_ls", "angularls", "cssls", "css_variables", "emmet_ls", "eslint@4.8.0", "html", "somesass_ls", "vtsls"
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
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "chrome", "firefox"
        -- add more arguments for adding more debuggers
      },
      handlers = {
        chrome = function()
          local dap = require "dap"
          local exts = {
            "javascript",
            "typescript",
          }
          dap.adapters.chrome = {
            type = "executable",
            command = "node",
            args = { "/home/ergoproxy13/.local/share/nvim/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" }, -- TODO adjust
          }
          dap.adapters.firefox = {
            type = "executable",
            command = "node",
            args = { "/home/ergoproxy13/.local/share/nvim/mason/packages/firefox-debug-adapter/dist/adapter.bundle.js" }, -- TODO adjust
          }

          for i, ext in ipairs(exts) do
            dap.configurations[ext] = {
              {
                name = "Debug with Firefox",
                type = "firefox",
                request = "launch",
                reAttach = true,
                url = function()
                  local co = coroutine.running()
                  return coroutine.create(function()
                    vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:4200" }, function(url)
                      if url == nil or url == "" then
                        return
                      else
                        coroutine.resume(co, url)
                      end
                    end)
                  end)
                end,
                webRoot = "${workspaceFolder}",
                timeout = 90000,
                firefoxExecutable = "/usr/bin/firefox",
                tmpDir = "/home/ergoproxy13/Documents/faketmp",
              },
              {
                type = "chrome",
                request = "launch",
                name = 'Launch Chrome with "localhost"',
                url = function()
                  local co = coroutine.running()
                  return coroutine.create(function()
                    vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:4200" }, function(url)
                      if url == nil or url == "" then
                        return
                      else
                        coroutine.resume(co, url)
                      end
                    end)
                  end)
                end,
                webRoot = vim.fn.getcwd(),
                timeout = 90000,
                protocol = "inspector",
                sourceMaps = true,
                userDataDir = false,
                resolveSourceMapLocations = {
                  "${workspaceFolder}/**",
                  "!**/node_modules/**",
                },
              },
              {
                type = "chrome",
                request = "attach",
                name = "Attach Program (chrome, select port)",
                program = "${file}",
                cwd = vim.fn.getcwd(),
                sourceMaps = true,
                protocol = "inspector",
                port = function() return vim.fn.input("Select port: ", 9222) end,
                webRoot = "${workspaceFolder}",
              },
            }
          end
        end,
      },
    },
  },
}

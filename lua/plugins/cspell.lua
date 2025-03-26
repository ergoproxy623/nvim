local config = {
  -- The CSpell configuration file can take a few different names this option
  -- lets you specify which name you would like to use when creating a new
  -- config file from within the `Add word to cspell json file` action.
  --
  -- See the currently supported files in https://github.com/davidmh/cspell.nvim/blob/main/lua/cspell/helpers.lua
  config_file_preferred_name = 'cspell.json',

  -- A list of directories that contain additional cspell.json config files or
  -- support the creation of a new config file from a code action
  --
  -- looks for a cspell config in the ~/.config/ directory, or creates a file in the directory
  -- using 'config_file_preferred_name' when a code action for one of the locations is selected
  cspell_config_dirs = { "~/.config/nvim/" }

}


return {
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    depends = { "davidmh/cspell.nvim" },
    opts = function(_, opts)
      local cspell = require("cspell")
      opts.sources = opts.sources or {}
      table.insert(
        opts.sources,
        cspell.diagnostics.with({
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        config = config
        })
      )
      table.insert(opts.sources, cspell.code_actions.with({
        config = config
      }))
    end,

  },
}

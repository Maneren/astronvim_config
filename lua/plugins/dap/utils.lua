---@type LazySpec
return {
  "niuiic/dap-utils.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "niuiic/core.nvim",
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope.nvim",
    {
      "astrocore",
      opts = {
        mappings = {
          n = {
            ["<F5>"] = { function() require("dap-utils").continue() end, desc = "Start/Continue" },
            ["<Leader>dc"] = { function() require("dap-utils").continue() end, desc = "Start/Continue (F5)" },
            ["<Leader>dl"] = { function() require("dap").run_last() end, desc = "Run last config" },
          },
        },
      },
    },
  },
  opts = {
    rust = require("plugins.dap.languages.rust"),
    javascript = require("plugins.dap.languages.javascript"),
    python = require("plugins.dap.languages.python"),
    cpp = require("plugins.dap.languages.c"),
    c = require("plugins.dap.languages.c"),
    cs = require("plugins.dap.languages.cs"),
  },
}

--- Debugmaster - modal dap-ui alternative
--- https://github.com/miroshQa/debugmaster.nvim

---@type LazySpec
return {
  { "rcarriga/nvim-dap-ui", enabled = false },
  {
    "miroshQa/debugmaster.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "niuiic/dap-utils.nvim",
      -- "jbyuki/one-small-step-for-vimkind",
    },
    brach = "v2",
    specs = {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<leader>d"] = { function() require("debugmaster").mode.toggle() end, desc = "Debug master" },
          },
          v = {
            ["<leader>d"] = { function() require("debugmaster").mode.toggle() end, desc = "Debug master" },
          },
        },
      },
    },
  },
}

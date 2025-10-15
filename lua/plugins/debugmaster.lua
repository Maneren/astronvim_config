--- Debugmaster - modal dap-ui alternative
--- https://github.com/miroshQa/debugmaster.nvim

local mapping = {
  ["<leader>dd"] = { function() require("debugmaster").mode.toggle() end, desc = "Toggle debug master" },
}

---@type LazySpec
return {
  "miroshQa/debugmaster.nvim",
  dependencies = {
    "mfussenegger/nvim-dap",
    "niuiic/dap-utils.nvim",
    -- "jbyuki/one-small-step-for-vimkind", TODO: set this up
  },
  specs = {
    { "rcarriga/nvim-dap-ui", enabled = false },
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = mapping,
          v = mapping,
        },
      },
    },
  },
}

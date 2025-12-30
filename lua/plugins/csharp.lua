--- C# extended support
--- https://github.com/iabdelkareem/csharp.nvim

---@type LazySpec
return {
  "iabdelkareem/csharp.nvim",
  ft = { "cs" },
  dependencies = {
    "mason-org/mason.nvim",
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim",
  },
  opts = {},
}

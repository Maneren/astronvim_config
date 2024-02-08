return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "haydenmeade/neotest-jest",
    "rouge8/neotest-rust",
  },
  opts = function()
    return {
      adapters = {
        require("neotest-rust"),
        require("neotest-jest") {
          jestCommand = "pnpm jest",
          jestConfigFile = "jest.config.js",
          env = { CI = true },
          cwd = function() return vim.fn.getcwd() end,
        },
      },
    }
  end,
}

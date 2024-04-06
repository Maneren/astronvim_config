---@type LazySpec
return {
  "folke/neodev.nvim",
  ft = { "lua" },
  opts = {
    library = {
      plugins = {
        "neotest",
        "nvim-dap-ui",
        "nvim-treesitter",
        "plenary.nvim",
        "telescope.nvim",
      },
      types = true,
    },
  },
}

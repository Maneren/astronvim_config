--- Swaps binary operands
--- https://github.com/Wansmer/binary-swap.nvim

---@type LazySpec
return {
  "Wansmer/binary-swap.nvim",
  keys = { "gS", "gs" },
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["gS"] = {
              function() require("binary-swap").swap_operands() end,
              desc = "Swap operands",
            },
            ["gs"] = {
              function() require("binary-swap").swap_operands_with_operator() end,
              desc = "Swap operands with operator",
            },
          },
        },
      },
    },
  },
}

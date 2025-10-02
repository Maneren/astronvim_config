--- Swap binary operands and TS siblings
--- https://github.com/Maneren/binary-swap.nvim
--- https://github.com/Wansmer/sibling-swap.nvim

---@type LazySpec
return {
  {
    "Maneren/binary-swap.nvim",
    event = "User AstroFile",
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
  },
  {
    "Wansmer/sibling-swap.nvim",
    event = "User AstroFile",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
    },
    opts = {
      use_default_keymaps = false,
    },
    specs = {
      {
        "astrocore",
        ---@type AstroCoreOpts
        opts = {
          mappings = {
            n = {
              ["<s"] = {
                function() require("sibling-swap").swap_with_left() end,
                desc = "Swap previous sibling",
              },
              [">s"] = {
                function() require("sibling-swap").swap_with_right() end,
                desc = "Swap next sibling",
              },
              ["<S"] = {
                function() require("sibling-swap").swap_with_left_with_opp() end,
                desc = "Swap previous sibling (opposite)",
              },
              [">S"] = {
                function() require("sibling-swap").swap_with_right_with_opp() end,
                desc = "Swap next sibling (opposite)",
              },
            },
          },
        },
      },
    },
  },
}

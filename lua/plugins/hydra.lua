--- Sticky keybinds
--- https://github.com/nvimtools/hydra.nvim
--- extends astrocommunity

-- currently only used for side scroll

---@type LazySpec
return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  opts = {
    ["Side scroll"] = {
      mode = "n",
      body = "z",
      heads = {
        { "h", "5zh", { desc = "← one column" } },
        { "l", "5zl", { desc = "→ one column" } },
        { "H", "zH", { desc = "← half screen" } },
        { "L", "zL", { desc = "→ half screen" } },
      },
    },
  },
}

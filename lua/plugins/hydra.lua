--- Sticky keybinds
--- https://github.com/nvimtools/hydra.nvim

-- currently only used for side scroll

---@type LazySpec
return {
  "nvimtools/hydra.nvim",
  -- applying the config is handled by astrocommunity
  opts = {
    ["Side scroll"] = {
      mode = "n",
      body = "z",
      heads = {
        { "h", "5zh" },
        { "l", "5zl", { desc = "←/→" } },
        { "H", "zH" },
        { "L", "zL", { desc = "←/→ half screen" } },
      },
    },
  },
}

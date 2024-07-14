--- Sticky keybinds
--- https://github.com/anuvyklack/hydra.nvim

-- currently only used for side scroll

---@type LazySpec
return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  dependencies = {
    "jlanzarotta/bufexplorer",
    "sindrets/winshift.nvim",
    "mrjones2014/smart-splits.nvim",
  },
  config = function()
    local Hydra = require("hydra")

    Hydra {
      name = "Side scroll",
      mode = "n",
      body = "z",
      heads = {
        { "h", "5zh" },
        { "l", "5zl", { desc = "←/→" } },
        { "H", "zH" },
        { "L", "zL", { desc = "←/→ half screen" } },
      },
    }
  end,
}

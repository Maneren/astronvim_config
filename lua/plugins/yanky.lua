--- Yank history manager
--- https://github.com/gbprod/yanky.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "gbprod/yanky.nvim",
  event = "User AstroFile",
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["<C-P>"] = { "<Plug>(YankyPreviousEntry)", desc = "Previous put entry" },
            ["<C-N>"] = { "<Plug>(YankyNextEntry)", desc = "Next put entry" },
          },
        },
      },
    },
  },
}

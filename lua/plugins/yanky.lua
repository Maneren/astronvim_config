--- Yank history manager
--- https://github.com/gbprod/yanky.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "gbprod/yanky.nvim",
  event = "BufEnter",
  opts = {
    highlight = { timer = 200 },
  },
  specs = {
    {
      "AstroNvim/astrocore",
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

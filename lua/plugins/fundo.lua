--- Forever undofile
--- https://github.com/kevinhwang91/nvim-fundo

---@type LazySpec
return {
  "kevinhwang91/nvim-fundo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  build = function() require("fundo").install() end,
  opts = {},
  lazy = false,
  specs = {
    {
      "AstroNvim/astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          o = {
            undofile = true,
          },
        },
      },
    },
  },
}

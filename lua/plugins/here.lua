--- Toggle terminal in current buffer
--- https://github.com/jaimecgomezz/here.term

---@type LazySpec
return {
  "jaimecgomezz/here.term",
  event = "VeryLazy",
  opts = {},
  specs = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        options = {
          opt = {
            hidden = true,
          },
        },
      },
    },
  },
}

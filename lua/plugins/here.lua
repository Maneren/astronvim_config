--- Toggle terminal in current buffer
--- https://github.com/jaimecgomezz/here.term

---@type LazySpec
return {
  "jaimecgomezz/here.term",
  event = "BufEnter",
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

-- Toggle terminal in current buffer
-- https://github.com/jaimecgomezz/here.term

---@type LazySpec
return {
  "jaimecgomezz/here.term",
  event = "VeryLazy",
  opts = {},
  dependencies = {
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

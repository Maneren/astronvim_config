---@type LazySpec
return {
  "AckslD/nvim-trevJ.lua",
  event = "User AstroFile",
  opts = {},
  dependencies = {
    {
      "astrocore",
      ---@type AstroCoreOpts
      opts = {
        mappings = {
          n = {
            ["gj"] = {
              function() require("trevj").format_at_cursor() end,
              desc = "TrevJoin",
            },
          },
        },
      },
    },
  },
}

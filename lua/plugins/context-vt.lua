--- Shows block context in virtual text
--- https://github.com/andersevenrud/nvim_context_vt

---@type LazySpec
return {
  "andersevenrud/nvim_context_vt",
  event = "User AstroFile",
  opts = {
    min_rows = 15,
  },
  dependencies = {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<Leader>uv"] = {
            function() require("nvim_context_vt").toggle_context() end,
            desc = "Toggle virtual text context",
          },
        },
      },
    },
  },
}

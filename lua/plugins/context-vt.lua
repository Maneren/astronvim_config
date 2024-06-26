---@type LazySpec
return {
  "andersevenrud/nvim_context_vt",
  event = "User AstroFile",
  cmd = { "NvimContextVtToggle" },
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
            function() require("nvim_context_vt").toggle() end,
            name = "Toggle virtual text context",
          },
        },
      },
    },
  },
}

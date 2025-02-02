--- Multicursors
--- https://github.com/smoka7/multicursors.nvim
--- adapted from astrocommunity

---@type LazySpec
return {
  "smoka7/multicursors.nvim",
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  opts = {
    hint_config = {
      float_opts = {
        border = "rounded",
      },
      position = "bottom-right",
    },
    generate_hints = {
      normal = true,
      insert = true,
      extend = true,
    },
  },
  specs = {
    "astrocore",
    opts = {
      mappings = {
        n = {
          ["<Leader>m"] = {
            "<Cmd>MCstart<CR>",
            desc = "Multicursor mode",
          },
        },
        v = {
          ["<Leader>m"] = {
            "<Cmd>MCvisual<CR>",
            desc = "Multicursor mode",
          },
        },
      },
    },
  },
}

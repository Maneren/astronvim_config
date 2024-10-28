--- Multicursors
--- https://github.com/smoka7/multicursors.nvim

---@type LazySpec
return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
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
      normal = false,
      insert = false,
      extend = false,
      config = {
        column_count = 1,
      },
    },
  },
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<Leader>m",
      "<Cmd>MCstart<CR>",
      desc = "Create a selection for selected text or word under the cursor",
    },
  },
}

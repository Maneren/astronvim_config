--- Surround text with pairs
--- https://github.com/kylechui/nvim-surround

---@type LazySpec
return {
  "kylechui/nvim-surround",
  opts = {
    keymaps = {
      insert = "<C-g>z",
      insert_line = "<C-g>Z",
      normal = "gz",
      normal_cur = "gZ",
      normal_line = "gzz",
      normal_cur_line = "gZZ",
      visual = "gz",
      visual_line = "gZ",
      delete = "gzd",
      change = "gzr",
    },
  },
  specs = {
    { "catppuccin", opts = { integrations = { nvim_surround = true } } },
  },
}

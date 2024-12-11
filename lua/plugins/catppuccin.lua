return {
  "catppuccin/nvim",
  name = "catppuccin",
  ---@type CatppuccinOptions
  opts = {
    term_colors = true,
    integrations = {
      blink_cmp = true,
      grug_far = true,
      indent_blankline = { enabled = true },
      neotest = true,
      nvim_surround = true,
      octo = true,
      overseer = true,
      dadbod_ui = true,
    },
  },
}

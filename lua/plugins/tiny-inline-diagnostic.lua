--- Improved inline diagnostics
--- https://github.com/rachartier/tiny-inline-diagnostic.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  opts = {
    options = {
      show_source = true,
      multilines = {
        enabled = true,
        always_show = false,
        trim_whitespaces = true,
        tabstop = 2,
      },
      show_all_diags_on_cursorline = true,
      enable_on_insert = true,
      use_icons_from_diagnostic = true,
    },
  },
}

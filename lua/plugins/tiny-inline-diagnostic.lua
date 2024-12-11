---@type LazySpec
return {
  "rachartier/tiny-inline-diagnostic.nvim",
  opts = {
    blend = {
      factor = 0.2,
    },
    options = {
      show_source = true,
      throttle = 10,
      multiple_diag_under_cursor = true,
      multilines = true,
      show_all_diags_on_cursorline = true,
      enable_on_insert = true,
    },
  },
}

--- Yazi file manager integration
--- https://github.com/mikavilpas/yazi.nvim
--- extends astrocommunity

---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  ---@type YaziConfig
  opts = {
    open_multiple_tabs = true,
    future_features = {
      ya_emit_reveal = true,
      ya_emit_open = true,
    },
  },
}

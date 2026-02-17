--- Tree-sitter parser for rstml
--- https://github.com/rayliwell/tree-sitter-rstml

---@type LazySpec
return {
  "rayliwell/tree-sitter-rstml",
  event = "VeryLazy",
  dependencies = { "nvim-treesitter" },
  build = ":TSUpdate",
  opts = {},
}

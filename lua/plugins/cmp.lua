---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "kdheepak/cmp-latex-symbols" },
    {
      "David-Kunz/cmp-npm",
      opts = { ignore = { "beta", "rc" } },
    },
  },
  opts = function(_, opts)
    table.insert(opts.sources, { name = "latex_symbols", priority = 700 })
    table.insert(opts.sources, { name = "npm", priority = 1100 })
    opts.experimental = {
      ghost_text = true,
    }
    return opts
  end,
}

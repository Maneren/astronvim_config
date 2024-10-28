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

    local cmp = require("cmp")
    opts.mapping = cmp.mapping.preset.insert {
      ["<CR>"] = cmp.mapping {
        i = function(fallback)
          if cmp.visible() then
            cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm { select = true },
        c = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true },
      },
    }
    return opts
  end,
}

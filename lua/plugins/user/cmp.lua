---@type LazySpec
return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts.sources = cmp.config.sources {
      { name = "npm", priority = 1100 },
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 750 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    }
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

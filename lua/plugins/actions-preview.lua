local keymaps = {
  ["<Leader>la"] = {
    function() require("actions-preview").code_actions() end,
    desc = "LSP code action",
    cond = "testDocument/codeAction",
  },
}

---@type LazySpec
return {
  "aznhe21/actions-preview.nvim",
  event = "User AstroLspSetup",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    {
      "astrolsp",
      ---@type AstroLSPOpts
      opts = {
        mappings = {
          n = keymaps,
          x = keymaps,
        },
      },
    },
  },
}

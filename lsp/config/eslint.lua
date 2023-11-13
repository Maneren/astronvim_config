return {
  on_attach = function()
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
      command = "silent! EslintFixAll",
    })
  end,
}

return {
  "ixru/nvim-markdown",
  init = function()
    vim.g.vim_markdown_math = 1
    vim.g.tex_conceal = ""
  end,
  ft = { "markdown" },
}

---@type LazySpec
return {
  --- Markdown support (continue lists on new line, etc.)
  --- https://github.com/ixru/nvim-markdown
  {
    "ixru/nvim-markdown",
    ft = { "markdown" },
  },
  --- Markdown preview
  --- https://github.com/iamcco/markdown-preview.nvim
  --- extends astrocommunity
  {
    "iamcco/markdown-preview.nvim",
    specs = {
      {
        "astrocore",
        ---@type AstroCoreOpts
        opts = {
          options = {
            g = {
              mkdp_page_title = "${name}",
              mkdp_port = "4333",
            },
          },
        },
      },
    },
  },
}

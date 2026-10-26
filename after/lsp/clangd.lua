return {
  capabilities = { offsetEncoding = "utf-8" },
  cmd = {
    "clangd",
    "--completion-style=bundled",
    "--enable-config",
    "--experimental-modules-support",
    "--fallback-style=llvm",
    "--header-insertion-decorators",
    "--malloc-trim",
    "--pch-storage=disk",
  },
}

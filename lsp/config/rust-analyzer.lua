return {
  standalone = false,
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true,
        -- https://github.com/rust-analyzer/rust-analyzer/issues/6835
        disabled = { "unresolved-macro-call" },
        enableExperimental = true,
      },
      completion = {
        autoself = { enable = true },
        autoimport = { enable = true },
        postfix = { enable = true },
      },
      imports = {
        group = { enable = true },
        merge = { glob = false },
        prefix = "self",
        granularity = {
          enforce = true,
          group = "crate",
        },
      },
      cargo = {
        loadOutDirsFromCheck = true,
        autoreload = true,
        runBuildScripts = true,
        features = "all",
      },
      procMacro = { enable = true },
      lens = {
        enable = true,
        run = { enable = true },
        debug = { enable = true },
        implementations = { enable = true },
        references = {
          adt = { enable = true },
          enumVariant = { enable = true },
          method = { enable = true },
          trait = { enable = true },
        },
      },
      inlayHints = {
        enable = true,
        bindingModeHints = { enable = false },
        chainingHints = { enable = true },
        closingBraceHints = {
          enable = true,
          minLines = 10,
        },
        closureReturnTypeHints = { enable = "always" },
        lifetimeElisionHints = { enable = "skip_trivial" },
        parameterHints = { enable = false },
        typeHints = { enable = true },
      },
      check = {
        enable = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
    },
  },
}

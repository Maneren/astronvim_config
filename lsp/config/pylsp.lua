return {
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        black = { enabled = false },
        jedi_completion = { fuzzy = true },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        pylint = { enabled = false, executable = "pylint" },
        isort = { enabled = false },
        pylsp_mypy = { enabled = false },
        ruff = { enabled = false },
        rope_autoimport = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
}

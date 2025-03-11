--- VSCode Icons
--- https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/recipes/vscode-icons
--- adapted from astrocommunity

---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      icons = {
        ActiveLSP = "",
        ActiveTS = "",
        ArrowLeft = "",
        ArrowRight = "",
        BufferClose = "󰅖",
        DapBreakpoint = "",
        DapBreakpointCondition = "",
        DapBreakpointRejected = "",
        DapLogPoint = ".>",
        DapStopped = "󰁕",
        DefaultFile = "󰈙",
        Diagnostic = "󰒡",
        DiagnosticError = "",
        DiagnosticHint = "󰌵",
        DiagnosticInfo = "󰋼",
        DiagnosticWarn = "",
        Ellipsis = "…",
        FileModified = "",
        FileReadOnly = "",
        FoldClosed = "",
        FoldOpened = "",
        FoldSeparator = " ",
        FolderClosed = "",
        FolderEmpty = "",
        FolderOpen = "",
        Git = "󰊢",
        GitAdd = "",
        GitBranch = "",
        GitChange = "",
        GitConflict = "",
        GitDelete = "",
        GitIgnored = "◌",
        GitRenamed = "➜",
        GitStaged = "✓",
        GitUnstaged = "✗",
        GitUntracked = "★",
        LSPLoaded = "",
        LSPLoading1 = "",
        LSPLoading2 = "󰀚",
        LSPLoading3 = "",
        MacroRecording = "",
        Paste = "󰅌",
        Search = "",
        Selected = "❯",
        Spellcheck = "󰓆",
        TabClose = "󰅙",
      },
    },
  },
  {
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      lsp = {
        array = { glyph = "" },
        boolean = { glyph = "" },
        key = { glyph = "" },
        namespace = { glyph = "" },
        null = { glyph = "" },
        number = { glyph = "" },
        object = { glyph = "" },
        package = { glyph = "" },
        string = { glyph = "" },
        class = { glyph = "" },
        color = { glyph = "" },
        constant = { glyph = "" },
        constructor = { glyph = "" },
        enum = { glyph = "" },
        enummember = { glyph = "" },
        event = { glyph = "" },
        field = { glyph = "" },
        file = { glyph = "" },
        folder = { glyph = "" },
        ["function"] = { glyph = "" },
        interface = { glyph = "" },
        keyword = { glyph = "" },
        method = { glyph = "" },
        module = { glyph = "" },
        operator = { glyph = "" },
        property = { glyph = "" },
        reference = { glyph = "" },
        snippet = { glyph = "" },
        struct = { glyph = "" },
        text = { glyph = "" },
        typeparameter = { glyph = "" },
        unit = { glyph = "" },
        value = { glyph = "" },
        variable = { glyph = "" },
      },
    },
  },
}

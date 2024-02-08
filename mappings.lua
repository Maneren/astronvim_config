return {
  n = {
    -- make copy-pasting use the system clipboard by default
    p = { '"+p' },
    P = { '"+P' },
    ["<leader>C"] = { name = "Crates" },
    ["<leader>T"] = { name = "Tests" },
    ["<leader>r"] = { name = "Search and replace" },
    ["<leader>m"] = { name = "Markdown" },
    ["<leader>lr"] = { function() require("lspactions").rename() end, desc = "Rename symbol" },
    ["<leader>la"] = { function() vim.lsp.buf.code_action() end, desc = "Code actions" },
    ["<leader>le"] = { function() vim.lsp.buf.definition() end, desc = "Show definition" },
    ["<leader>ld"] = { function() vim.lsp.buf.declaration() end, desc = "Show declaration" },
    ["<leader>lm"] = { function() vim.lsp.buf.implementation() end, desc = "Show implementations" },
    ["<leader>lR"] = { function() vim.lsp.buf.references() end, desc = "Show references" },
    ["<leader>lh"] = { function() require("hover").hover() end, desc = "Hover" },
    ["<leader>lH"] = { function() require("hover").hover_select() end, desc = "Hover (select)" },
    ["<leader>Ct"] = { function() require("crates").toggle() end, desc = "Toggle extra crates.io information" },
    ["<leader>Cr"] = { function() require("crates").reload() end, desc = "Reload information from crates.io" },
    ["<leader>CU"] = { function() require("crates").upgrade_crate() end, desc = "Upgrade a crate" },
    ["<leader>CA"] = { function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
    ["<leader>Tr"] = { function() require("neotest").run.run() end, desc = "Run closest test" },
    ["<leader>Tf"] = { function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run current file" },
    ["<leader>Td"] = { function() require("neotest").run.run { strategy = "dap" } end, desc = "Debug closest test" },
    ["<leader>Tc"] = { function() require("neotest").summary.toggle() end, desc = "Toggle summary window" },
    ["<leader>mp"] = { function() vim.cmd("MarkdownPreview") end, desc = "Open preview" },
    ["<leader>mP"] = { function() vim.cmd("MarkdownPreviewStop") end, desc = "Close preview" },
    ["<leader>mf"] = { function() require("tablemd").format() end, desc = "Format table" },
    ["<leader>mc"] = { function() require("tablemd").insertColumn(false) end, desc = "Insert column" },
    ["<leader>md"] = { function() require("tablemd").deleteColumn() end, desc = "Delete column" },
    ["<leader>mr"] = { function() require("tablemd").insertRow(false) end, desc = "Insert row above" },
    ["<leader>mR"] = { function() require("tablemd").insertRow(true) end, desc = "Insert row below" },
    ["<leader>mj"] = { function() require("tablemd").alignColumn("left") end, desc = "Align column left" },
    ["<leader>mk"] = { function() require("tablemd").alignColumn("center") end, desc = "Align column center" },
    ["<leader>ml"] = { function() require("tablemd").alignColumn("right") end, desc = "Align column right" },
    ["<leader>ss"] = { function() require("spectre").toggle() end, desc = "Toggle Spectre" },
    ["<leader>sw"] = {
      function() require("spectre").open_visual { select_word = true } end,
      desc = "Search current word",
    },
    ["<leader>sf"] = {
      function() require("spectre").open_file_search { select_word = true } end,
      desc = "Search word in current file",
    },
  },
  v = {
    -- Also in visual mode
    x = { '"+x' },
    y = { '"+y' },
    p = { '"_d"+p' },
    P = { '"_d"+P' },
    ["<leader>C"] = { name = "Crates" },
    ["<leader>lr"] = { function() require("lspactions").rename() end, desc = "Rename symbol" },
    ["<leader>CU"] = { function() require("crates").upgrade_crates() end, desc = "Upgrade selected crates" },
    ["<leader>sw"] = {
      function()
        vim.cmd("startnormal")
        require("spectre").open_visual()
      end,
    },
  },
}

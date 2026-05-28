if vim.g.neovide then
  vim.env.TERM = "xterm-256color"
end

-- Enable the experimental ui2
require("vim._core.ui2").enable {
  msg = { target = "msg" },
}

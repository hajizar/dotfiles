-- Key mappings for goto-breakpoints
local bkps = require("goto-breakpoints")
vim.keymap.set("n", "<leader>bk", bkps.prev, {})
vim.keymap.set("n", "<leader>bj", bkps.next, {})
vim.keymap.set("n", "<leader>bs", bkps.stopped, {})

-- Key mappings for codewindow
local codewindow = require("codewindow")
vim.keymap.set("n", "<leader>mm", codewindow.toggle_minimap, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mo", codewindow.open_minimap, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>mc", codewindow.close_minimap, { noremap = true, silent = true })

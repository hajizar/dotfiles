-- Key mappings for goto-breakpoints
local bkps = require("goto-breakpoints")
vim.keymap.set("n", "<leader>bk", bkps.prev, {})
vim.keymap.set("n", "<leader>bj", bkps.next, {})
vim.keymap.set("n", "<leader>bs", bkps.stopped, {})

-- Key mappings for snacks
local snacks = require("snacks")
vim.keymap.set("n", "<leader>gT", snacks.picker.git_diff, { noremap = true, silent = true })

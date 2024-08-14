-- Key mappings for Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

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

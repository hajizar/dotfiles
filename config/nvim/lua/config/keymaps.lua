-- Key mappings for goto-breakpoints
local bkps = require("goto-breakpoints")
vim.keymap.set("n", "<leader>bk", bkps.prev, { desc = "Previous Breakpoint", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bj", bkps.next, { desc = "Next Breakpoint", noremap = true, silent = true })
vim.keymap.set("n", "<leader>bs", bkps.stopped, { desc = "Stopped Breakpoint", noremap = true, silent = true })

-- Key mappings for snacks
local snacks = require("snacks")
vim.keymap.set("n", "<leader>gT", snacks.picker.git_diff, { desc = "Git Diff (Hunks)", noremap = true, silent = true })

-- Key mappings for gitlinker
local gitlinker = require("gitlinker")
vim.keymap.set(
  { "n", "v" },
  "<leader>gy",
  gitlinker.get_buf_range_url,
  { desc = "Copy permalink", noremap = true, silent = true }
)

vim.keymap.set(
  { "n", "v" },
  "<leader>gY",
  gitlinker.get_repo_url,
  { desc = "Copy repository", noremap = true, silent = true }
)

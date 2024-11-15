return {
  "AdiY00/copy-tree.nvim",
  cmd = "CopyTree",
  config = function()
    require("copy-tree").setup()
  end,
  vim.keymap.set("n", "<leader>ct", "<cmd>CopyTree<cr>", { desc = "Copy project tree" }),
}

return {
  {
    "Isrothy/neominimap.nvim",
    version = "v3.x.x",
    lazy = false,
    keys = {
      { "<leader>mm", "<cmd>Neominimap Toggle<cr>", desc = "Toggle global minimap" },
      { "<leader>mo", "<cmd>Neominimap Enable<cr>", desc = "Enable global minimap" },
      { "<leader>mc", "<cmd>Neominimap Disable<cr>", desc = "Disable global minimap" },
    },
    init = function()
      vim.opt.wrap = false
      vim.opt.sidescrolloff = 36

      ---@type Neominimap.UserConfig
      vim.g.neominimap = {
        auto_enable = false,
      }
    end,
  },
}

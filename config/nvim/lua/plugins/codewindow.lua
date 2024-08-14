return {
  {
    "gorbit99/codewindow.nvim",
    config = function()
      local codewindow = require("codewindow")
      codewindow.setup({
        auto_enable = false, -- Set to true to automatically open codewindow on startup
        exclude_filetypes = { "neo-tree", "packer" }, -- Exclude certain filetypes
        minimap_width = 10, -- Width of the minimap
        use_lsp = true, -- Use the LSP to color the minimap
        use_treesitter = true, -- Use TreeSitter to color the minimap
        use_git = true, -- Show small dots to indicate git additions and deletions
        icons = {
          "▁",
          "▂",
          "▃",
          "▄",
          "▅",
          "▆",
          "▇",
          "█", -- Symbols for representing code blocks
        },
        window_border = "single", -- Border style for the codewindow
      })
      codewindow.apply_default_keybinds()
    end,
  },
}

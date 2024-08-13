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

      -- Bindings for opening and closing the minimap
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mm",
        ':lua require("codewindow").toggle_minimap()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mo",
        ':lua require("codewindow").open_minimap()<CR>',
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>mc",
        ':lua require("codewindow").close_minimap()<CR>',
        { noremap = true, silent = true }
      )

      codewindow.apply_default_keybinds()
    end,
  },
}

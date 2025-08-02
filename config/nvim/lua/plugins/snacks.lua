return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        exclude = {
          ".git",
          ".hypothesis",
          ".pytest_cache",
          ".ruff_cache",
          ".venv",
          "__pycache__",
          "node_modules",
        },
      },
      explorer = {
        enabled = true,
        replace_netrw = true,
      },
    },
    keys = {
      { "<leader>gd", false },
    },
  },
}

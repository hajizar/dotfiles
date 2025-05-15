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
    },
    keys = {
      { "<leader>gd", false },
    },
  },
}

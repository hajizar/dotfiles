return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        ignored = true,
        follow = true,
        exclude = {
          ".git",
          ".hypothesis",
          ".pytest_cache",
          ".ruff_cache",
          ".venv",
          "__pycache__",
          "node_modules",
        },
        sources = {
          files = {
            cmd = "fd",
            args = {
              "--type", "f",
              "--type", "l",
              "--color", "never",
              "--hidden",
              "--exclude", ".git",
              "--exclude", ".hypothesis",
              "--exclude", ".pytest_cache",
              "--exclude", ".ruff_cache",
              "--exclude", ".venv",
              "--exclude", "__pycache__",
              "--exclude", "node_modules",
            },
          },
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

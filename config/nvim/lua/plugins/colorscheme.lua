return {
  {
    "projekt0n/github-nvim-theme",
    config = function()
      require("github-theme").setup({
        options = {
          transparent = true,
          styles = {
            comments = "italic",
            keywords = "bold",
            types = "italic,bold",
          },
          inverse = {
            visual = true,
          },
        },
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "github_dark",
    },
  },
}

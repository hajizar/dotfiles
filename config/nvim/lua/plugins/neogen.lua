return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup({
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "reST",
          },
        },
      },
    })
  end,
}

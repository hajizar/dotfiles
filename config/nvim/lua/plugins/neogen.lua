return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    require("neogen").setup({
      enabled = true,
      languages = {
        python = {
          template = {
            annotation_convention = "reST", -- Set 'reST' as the default docstring format for Python
          },
        },
      },
    })
  end,
}
-- Disable auto formattin on save for python files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python", "yaml", "hcl" },
  callback = function()
    vim.b.autoformat = false
  end,
})

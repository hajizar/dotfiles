-- General settings
vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Lazy.nvim setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
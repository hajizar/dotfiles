-- ~/.config/nvim/lua/plugins/cite.lua
return {
  {
    "hajizar/cite",
    config = function()
      require("cite").setup({
        keymap = "<leader>ac",
        format = function(path, start_line, end_line)
          if start_line == end_line then
            return ("@%s#L%d"):format(path, start_line)
          end

          return ("@%s#L%d-%d"):format(path, start_line, end_line)
        end,
      })
    end,
  },
}

require('nvim-autopairs').setup({
    check_ts = true,  -- Enable treesitter integration
    ts_config = {
      lua = {'string'},  -- It will not add a pair on that treesitter node
      javascript = {'template_string'},
      java = false,  -- Don't check treesitter on java
    }
  })
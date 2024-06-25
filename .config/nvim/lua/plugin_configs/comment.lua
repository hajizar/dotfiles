require('Comment').setup({
    toggler = {
      line = 'gcc',  -- Line-comment toggle keymap
      block = 'gbc',  -- Block-comment toggle keymap
    },
    opleader = {
      line = 'gc',  -- Line-comment operator keymap
      block = 'gb',  -- Block-comment operator keymap
    },
    extra = {
      above = 'gcO',  -- Add comment on the line above
      below = 'gco',  -- Add comment on the line below
      eol = 'gcA',  -- Add comment at the end of line
    },
    mappings = {
      basic = true,  -- Enable basic mappings
      extra = true,  -- Enable extra mappings
      extended = false,  -- Disable extended mappings
    },
  })
require('neo-tree').setup {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
    },
    buffers = {
      show_hidden = true,
    },
    git_status = {
      show_hidden = true,
    },
  }
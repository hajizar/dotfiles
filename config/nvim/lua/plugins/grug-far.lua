return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      engines = {
        ripgrep = {
          extraArgs = "--hidden --glob=!.git/**",
        },
      },
    },
  },
}
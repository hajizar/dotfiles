return {
  {
    "rhajizada/placeholder",
    config = function()
      require("placeholder").setup({
        keymap = "<leader>cj",
        dap_config_types = {
          go = {
            debugger = "go",
          },
          python = {
            debugger = "debugpy",
          },
          lua = {
            debugger = "nlua",
          },
          javascript = {
            debugger = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            args = {},
            env = { NODE_ENV = "development" },
          },
          typescript = {
            debugger = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            args = {},
            env = { NODE_ENV = "development" },
          },
        },
      })
    end,
  },
}

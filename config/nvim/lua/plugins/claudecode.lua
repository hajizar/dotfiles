local claude = vim.fn.exepath("claude")

return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    init = function()
      vim.env.CLAUDE_CODE_USE_VERTEX = os.getenv("CLAUDE_CODE_USE_VERTEX")
      vim.env.ANTHROPIC_VERTEX_PROJECT_ID = os.getenv("ANTHROPIC_VERTEX_PROJECT_ID")
      vim.env.CLOUD_ML_REGION = os.getenv("CLOUD_ML_REGION")
    end,
    opts = {
      terminal_cmd = claude ~= "" and claude or "claude",
    },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
}

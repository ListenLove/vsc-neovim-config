-- 完全禁用 LazyVim 的默认 treesitter 和开发插件
return {
  -- 高优先级禁用（确保在 LazyVim 默认配置之前加载）
  priority = 10000,
  
  -- 禁用所有 treesitter 相关
  { "nvim-treesitter/nvim-treesitter", enabled = false },
  { "nvim-treesitter/nvim-treesitter-textobjects", enabled = false },
  { "nvim-treesitter/nvim-treesitter-context", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },
  { "nvim-treesitter/playground", enabled = false },
  
  -- 禁用 LSP 和 Mason（配置文件不需要）
  { "neovim/nvim-lspconfig", enabled = false },
  { "mason-org/mason.nvim", enabled = false },
  { "mason-org/mason-lspconfig.nvim", enabled = false },
  
  -- 禁用调试器
  { "mfussenegger/nvim-dap", enabled = false },
  { "rcarriga/nvim-dap-ui", enabled = false },
  { "theHamsta/nvim-dap-virtual-text", enabled = false },
  { "mxsdev/nvim-dap-vscode-js", enabled = false },
  { "nvim-neotest/nvim-nio", enabled = false },
  
  -- 禁用测试框架
  { "nvim-neotest/neotest", enabled = false },
  { "nvim-neotest/neotest-python", enabled = false },
  
  -- 禁用虚拟环境选择器
  { "linux-cultist/venv-selector.nvim", enabled = false },
}

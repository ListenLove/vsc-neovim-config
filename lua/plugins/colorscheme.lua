-- 主题配置：Monokai Pro + TokyoNight
return {
  -- TokyoNight 主题
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
    },
  },

  -- Monokai Pro 主题（主要使用）
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "pro",
        -- 内置语法高亮增强
        highlight_groups = {
          -- 函数和关键字加粗
          Function = { bold = true },
          Keyword = { bold = true },
          -- 字符串斜体
          String = { italic = true },
          -- 注释灰色
          Comment = { italic = true },
        },
      })
    end,
  },

  -- 配置 LazyVim 使用 Monokai Pro
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "monokai-pro",
    },
  },

  -- 启用内置语法高亮
  {
    "LazyVim/LazyVim",
    opts = function()
      -- 使用内置语法高亮（替代 treesitter）
      vim.opt.syntax = "on"
    end,
  },
}

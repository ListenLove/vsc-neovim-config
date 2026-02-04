-- 公共插件配置
-- 这些插件在 VSCode 和原生 Neovim 中都可用

return {
  -- 增强周围符号编辑 (ys, ds, cs)
  -- 例如: ysiw" 可以将当前单词用双引号包围
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },

  -- 快速注释 (gc)
  -- 例如: gcc 注释当前行, gc2j 注释向下2行
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
      -- 兼容 VS Code 习惯: Ctrl + / (在终端里通常识别为 Ctrl + _)
      vim.keymap.set("n", "<C-_>", function() require("Comment.api").toggle.linewise.current() end, { desc = "Toggle Comment" })
      vim.keymap.set("v", "<C-_>", "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle Comment" })
    end,
  },

  -- 增强 . 重复操作
  -- 让插件操作也能支持 . 重复
  { "tpope/vim-repeat" },

  -- 快速跳转
  -- 类似于 EasyMotion/Sneak，但在 Neovim 中体验更好
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      -- 调整快捷键以避免冲突 (s/S 原生功能保留)
      { "gs", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "gr", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
}

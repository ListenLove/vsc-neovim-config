-- 键位映射配置
-- 这些映射会在 lazy.nvim 启动后加载

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 设置 leader 键为空格
keymap("", "<Space>", "<Nop>", opts)

-- 窗口移动
keymap("n", "<leader>h", "<C-w>h", { remap = true })
keymap("n", "<leader>j", "<C-w>j", { remap = true })
keymap("n", "<leader>k", "<C-w>k", { remap = true })
keymap("n", "<leader>l", "<C-w>l", { remap = true })

-- 行首行尾跳转
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- 粘贴不复制 (Visual模式)
keymap("v", "<leader>p", '"_dP', opts)

-- 系统剪贴板操作
keymap("v", "<leader>c", '"+y', opts)
keymap("v", "<C-c>", '"+y', opts)
keymap("n", "<leader>v", '"+p', opts)

-- 清除搜索高亮
keymap("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })

-- 翻页后居中
keymap("n", "<C-f>", "<C-f>zz", opts)
keymap("n", "<C-b>", "<C-b>zz", opts)

-- 搜索结果跳转后居中
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)
keymap("n", "*", "*zzzv", opts)
keymap("n", "#", "#zzzv", opts)
keymap("n", "g*", "g*zzzv", opts)
keymap("n", "g#", "g#zzzv", opts)

-- 便捷居中
keymap("n", "<leader>z", "zz", opts)

-- Buffer/Tab 导航
keymap("n", "<C-M-h>", ":bprevious<CR>", opts)  -- Ctrl+Alt+h 上一个 buffer
keymap("n", "<C-M-l>", ":bnext<CR>", opts)      -- Ctrl+Alt+l 下一个 buffer

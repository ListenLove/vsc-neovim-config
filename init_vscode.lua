-- 原始的 init.lua 内容（用于在 VSCode 的 vscode-neovim 插件中加载）
-- 下面内容为原始配置的备份

-- 设置 leader 键为空格
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = 'utf-8'
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "80"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
-- vim.o.st=4
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 开启搜索高亮
vim.o.hlsearch = true
-- 开启增量搜索（边输入边高亮）
vim.o.incsearch = true
-- 忽略大小写
vim.o.ignorecase = true
-- 智能大小写敏感（如果搜索模式包含大写字母，则变为大小写敏感）
vim.o.smartcase = true
-- 边输入边搜索
vim.o.incsearch = true
-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 2
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.wo.wrap = false
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = '<,>,[,]'
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- smaller updatetime
vim.o.updatetime = 300
-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
vim.o.timeoutlen = 500
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = true
vim.o.listchars = "space:·"
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. 'c'
-- 补全最多显示10行
vim.o.pumheight = 10
-- 永远显示 tabline
vim.o.showtabline = 2

-- 显示 hex 颜色
vim.opt.termguicolors = true

-- 在可视模式下使用 <leader>p 覆盖而不复制被覆盖的文本
vim.api.nvim_set_keymap('v', '<leader>p', '"_dP', { noremap = true})

-- 设置 <leader>hjkl 为窗口移动
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>h', { noremap = false})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', { noremap = false})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', { noremap = false})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', { noremap = false})

-- 设置大写 H L 为跳转到行首中间行尾
vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true})
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true})

-- 设置光标始终在中间
vim.o.scrolloff = 999
vim.o.sidescrolloff = 999

-- 启用默认折叠
vim.o.foldenable = true
vim.o.foldmethod = 'indent'  -- 可改成你常用的方式

-- 设置启用鼠标
vim.o.mouse = "a"

-- 使用系统剪贴板
vim.o.clipboard = "unnamedplus"
-- 设置Leader+c 复制到系统剪贴板
vim.api.nvim_set_keymap('v', '<leader>c', '+"y', { noremap = true})
vim.api.nvim_set_keymap('v', '<C-c>', '+"y', { noremap = true})

-- 设置Leader+v 粘贴系统剪贴板
vim.api.nvim_set_keymap('n', '<leader>v', '+"p', { noremap = true})

-- 设置快捷键来清除搜索高亮，双击 Esc 键清除高亮
vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch<CR>', { silent = true })

-- 翻页/半页滚动后自动将光标置于屏幕中间
-- 注意：在 VS Code 中使用时，确保 <C-f>/<C-b>/<C-d>/<C-u> 没有被 VS Code 抢占
local _opts = { noremap = true, silent = true }
-- 由于 VS Code 默认占用了 <C-d> 和 <C-u>，所以这里注释掉
-- vim.keymap.set('n', '<C-d>', '<C-d>zz', _opts)
-- vim.keymap.set('n', '<C-u>', '<C-u>zz', _opts)
vim.keymap.set('n', '<C-f>', '<C-f>zz', _opts)
vim.keymap.set('n', '<C-b>', '<C-b>zz', _opts)

-- 搜索结果跳转后居中并展开折叠
vim.keymap.set('n', 'n', 'nzzzv', _opts)
vim.keymap.set('n', 'N', 'Nzzzv', _opts)
vim.keymap.set('n', '*', '*zzzv', _opts)
vim.keymap.set('n', '#', '#zzzv', _opts)
vim.keymap.set('n', 'g*', 'g*zzzv', _opts)
vim.keymap.set('n', 'g#', 'g#zzzv', _opts)

-- 便捷居中操作：<leader>z 等价于内置的 zz
vim.keymap.set('n', '<leader>z', 'zz', _opts)

-- 这里可以继续保留原有的更多配置...（如有）

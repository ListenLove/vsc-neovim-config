local opt = vim.opt
local g = vim.g

-- 基础设置
g.mapleader = " "
g.encoding = "UTF-8"
opt.fileencoding = 'utf-8'

-- 界面显示
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "120"
opt.cmdheight = 2
opt.showtabline = 2
opt.termguicolors = true
opt.background = "dark"
opt.list = true
opt.listchars = "space:·"
opt.splitbelow = true
opt.splitright = true

-- 缩进与Tab
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true
opt.shiftround = true

-- 搜索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 行为
opt.autoread = true
opt.wrap = false
opt.whichwrap = '<,>,[,]'
opt.hidden = true
opt.mouse = "a"
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.updatetime = 300
opt.timeoutlen = 500
opt.completeopt = "menu,menuone,noselect,noinsert"
opt.wildmenu = true
opt.shortmess:append('c')
opt.pumheight = 10
opt.clipboard = "unnamedplus"

-- 折叠
opt.foldenable = true
opt.foldmethod = 'indent'

-- 光标位置
opt.scrolloff = 999
opt.sidescrolloff = 999

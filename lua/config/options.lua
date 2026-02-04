-- 基础选项配置
-- 这些选项会在 lazy.nvim 启动前加载

local opt = vim.opt
local g = vim.g

-- Leader 键
g.mapleader = " "
g.maplocalleader = " "

-- 编码
g.encoding = "UTF-8"
opt.fileencoding = "utf-8"
opt.termguicolors = true

-- 界面显示
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "120"
opt.cmdheight = 2
opt.showtabline = 2
opt.background = "dark"
opt.list = true
-- space: 显示空格为 ·，tab: 显示 Tab 为两个空格（不显示 ^I）
opt.listchars = { space = "·", tab = "  " }
opt.splitbelow = true
opt.splitright = true

-- 缩进与 Tab
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
opt.whichwrap = "<,>,[,]"
opt.hidden = true
opt.mouse = "a"
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.updatetime = 300
opt.timeoutlen = 500
opt.completeopt = "menu,menuone,noselect,noinsert"
opt.wildmenu = true
opt.shortmess:append("c")
opt.pumheight = 10
opt.clipboard = "unnamedplus"

-- 折叠
opt.foldenable = true
opt.foldmethod = "indent"

-- 光标位置（始终居中）
opt.scrolloff = 999
opt.sidescrolloff = 999

-- 为不同文件类型设置合适的 tab/indent
local ft_tabs = {
  lua = 2,
  go = 2,
  python = 4,
  javascript = 2,
  typescript = 2,
  json = 2,
  html = 2,
  css = 2,
}

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = vim.tbl_keys(ft_tabs),
  callback = function(ev)
    local ts = ft_tabs[ev.match] or 2
    vim.bo[ev.buf].expandtab = true
    vim.bo[ev.buf].tabstop = ts
    vim.bo[ev.buf].shiftwidth = ts
    vim.bo[ev.buf].softtabstop = ts
  end,
})

-- 为 Go 文件优化显示（Go 使用 Tab，显示为空格而非 ^I）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.listchars = { space = "·", tab = "  " }
  end,
})

-- RetabSpaces 命令：将当前 buffer 中的所有 tab 转换为空格
vim.api.nvim_create_user_command("RetabSpaces", function(opts)
  local cur = vim.bo.expandtab
  vim.bo.expandtab = true
  vim.cmd("retab")
  vim.bo.expandtab = cur
  if not opts.bang then
    print("Converted tabs to spaces in buffer")
  end
end, { nargs = 0, desc = "Convert tabs to spaces in current buffer" })

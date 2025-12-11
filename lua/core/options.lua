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

-- 为不同文件类型设置合适的 tab/indent（按需修改）
local ft_tabs = {
	lua = 2,
	go = 2,        -- 注意：Go 生态惯例是使用 TAB，若希望保留 TAB 可在下面覆盖为 noexpandtab
	python = 4,
	javascript = 2,
	typescript = 2,
	json = 2,
	html = 2,
	css = 2,
}

vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = vim.tbl_keys(ft_tabs),
	callback = function(ev)
		local ts = ft_tabs[ev.match] or 2
		-- 使用 buffer-local 选项，确保不同类型文件互不干扰
		vim.bo[ev.buf].expandtab = true
		vim.bo[ev.buf].tabstop = ts
		vim.bo[ev.buf].shiftwidth = ts
		vim.bo[ev.buf].softtabstop = ts
	end,
})

-- 如果你希望某些语言（例如 Go）使用真实的 TAB 而非空格，
-- 可以为其单独覆盖：例如下面示例会让 go 文件使用真实 TAB
vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = {"go"},
	callback = function(ev)
		-- 使用真实 Tab（如果你更偏向 gofmt 的默认行为）
		-- 注释掉下面两行以继续使用空格
		-- vim.bo[ev.buf].expandtab = false
		-- vim.bo[ev.buf].tabstop = 2
	end,
})

-- 便捷命令：把当前 buffer 中的所有 tab 转换为相应数量的空格
-- 使用方法：在 buffer 中执行 `:RetabSpaces`。
vim.api.nvim_create_user_command('RetabSpaces', function(opts)
	-- 保留当前 expandtab 设置，确保按当前 buffer 配置执行
	local cur = vim.bo.expandtab
	vim.bo.expandtab = true
	-- retab 会将文件中的 TAB 替换为空格（当 expandtab = true 时）
	vim.cmd('retab')
	vim.bo.expandtab = cur
	if not opts.bang then
		print('Converted tabs to spaces in buffer')
	end
end, { nargs = 0, desc = 'Convert tabs to spaces in current buffer' })


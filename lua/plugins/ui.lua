-- UI 配置：使用 which-key（优化配置）
return {
	-- 启用并优化 which-key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			-- 增加延迟，减少干扰（默认 200ms）
			-- delay = 300,

			-- 使用 classic 预设，更简洁
			preset = "classic",

			-- 过滤配置，减少信息密度
			filter = function(mapping)
				-- 排除一些不常用的映射
				return mapping.desc and mapping.desc ~= ""
			end,

			-- 窗口配置
			win = {
				-- 不自动聚焦
				no_overlap = true,
				-- 窗口样式
				padding = { 1, 2 }, -- 上下，左右
				title = true,
				title_pos = "center",
				zindex = 1000,
				-- 使用更小的窗口
				wo = {
					winblend = 0,
				},
			},

			-- 布局配置
			layout = {
				width = { min = 20, max = 50 }, -- 限制最大宽度
				spacing = 3,
				align = "left",
			},

			-- 图标配置
			icons = {
				-- 使用更简单的图标
				breadcrumb = "»",
				separator = "➜",
				group = "+",
				ellipsis = "…",
				mappings = false, -- 不显示键位图标
			},

			-- 禁用某些触发器
			triggers = {
				{ "<auto>", mode = "nxso" }, -- 自动触发
			},

			-- 禁用特定键位（按 Esc 不会触发）
			disable = {
				-- 禁用 buftypes
				buftypes = {},
				-- 禁用文件类型
				filetypes = {},
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)

			-- 添加一些组描述
			wk.add({
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Code" },
				{ "<leader>d", group = "Debug" },
				{ "<leader>f", group = "File/Find" },
				{ "<leader>g", group = "Git" },
				{ "<leader>h", group = "Help" },
				{ "<leader>s", group = "Search" },
				{ "<leader>u", group = "UI" },
				{ "<leader>w", group = "Window" },
				{ "<leader>x", group = "Diagnostics" },
			})
		end,
	},

	-- 诊断配置
	{
		"neovim/nvim-lspconfig",
		opts = {
			diagnostics = {
				virtual_text = {
					prefix = "●",
					spacing = 4,
					source = "if_many",
				},
				float = {
					source = "always",
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
			},
		},
	},
}

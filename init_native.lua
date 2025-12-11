-- ==========================================
-- 1. 基础设置 (Basic Options)
-- ==========================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.signcolumn = "yes"
opt.termguicolors = true
opt.clipboard = "unnamedplus"

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- ==========================================
-- 2. 插件管理器安装 (Bootstrap Lazy.nvim)
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==========================================
-- 3. 插件列表与配置
-- ==========================================
require("lazy").setup({
  -- [主题] Monokai Pro (Sublime Text 风格)
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("monokai-pro").setup({
        filter = "pro", -- classic | octagon | pro | machine | ristretto | spectrum
      })
      vim.cmd([[colorscheme monokai-pro]])
    end,
  },

  -- [主题备选] TokyoNight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 800,
  },

  -- [Surround] 包裹文本处理 (类似 surround.vim)
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },

  -- [文件树]
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
      })
      vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Tree" })
    end,
  },

  -- [标签页]
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require("bufferline").setup({
        options = {
          mode = "buffers",
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
        }
      })
      vim.keymap.set('n', '<S-h>', ':BufferLineCyclePrev<CR>', { silent = true })
      vim.keymap.set('n', '<S-l>', ':BufferLineCycleNext<CR>', { silent = true })
      vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { silent = true })
    end
  },

  -- [状态栏]
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight" },
        sections = { lualine_c = { { 'filename', path = 1 } } }
      })
    end,
  },

  -- [语法高亮]
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "gomod", "lua", "json" },
        highlight = { enable = true },
        indent = { enable = false },
      })
    end,
  },
  -- [自动成对] 自动闭合括号、引号
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true -- 使用默认配置
  },
  -- [快速注释]
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
      -- 兼容 VS Code 习惯: Ctrl + / (在终端里通常识别为 Ctrl + _)
      vim.keymap.set('n', '<C-_>', function() require('Comment.api').toggle.linewise.current() end, { desc = "Toggle Comment" })
      vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = "Toggle Comment" })

    end
  },

  -- [Lua 开发增强] (智能感知 vim 全局变量等)
  {
    "folke/lazydev.nvim",
    ft = "lua", -- 仅在 lua 文件加载
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true }, -- 可选：vim.uv 类型定义

  -- [LSP 核心配置] (修复报错的关键部分)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1. 初始化 Mason
      require("mason").setup()

      -- 2. 定义 capabilities (补全能力)
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- 3. 使用 mason-lspconfig 自动设置 handlers
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "lua_ls" },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup({
              capabilities = capabilities,
            })
          end,

          ["lua_ls"] = function()
            require("lspconfig").lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  completion = {
                    callSnippet = "Replace",
                  },
                },
              },
            })
          end,

          ["gopls"] = function()
            require("lspconfig").gopls.setup({
              capabilities = capabilities,
              settings = {
                gopls = {
                  analyses = { unusedparams = true },
                  staticcheck = true,
                  gofumpt = true,
                },
              },
            })
          end,
        }
      })

      -- 4. 快捷键绑定 (LspAttach)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)
        end,
      })
    end,
  },

  -- [自动补全]
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },

  -- [文件搜索]
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep Files" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      -- 符号跳转 (类似 VS Code Ctrl+;)
      { "<C-;>", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
      { "<leader>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    },
  },
  -- [参数提示] 输入函数参数时显示签名提示
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts) require'lsp_signature'.setup(opts) end
  },
  -- [终端] ToggleTerm - 底部终端
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 10, -- 终端高度
        open_mapping = [[<C-\>]], -- 快捷键绑定 Ctrl + `
        direction = 'horizontal', -- 方向：底部水平
        shade_terminals = true,
        start_in_insert = true,   -- 打开后自动进入插入模式
        persist_size = true,
      })
      -- 解决终端模式下按 ESC 无法退出的问题
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts) -- ESC 退出插入模式
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      end

      local function vsplit_new_term()
        -- 获取 toggleterm 模块
        local status_ok, terminal = pcall(require, "toggleterm.terminal")
        if not status_ok then
          return
        end

        -- 获取所有已创建的终端
        local terminals = terminal.get_all()

        -- 找到下一个可用的 ID (当前最大 ID + 1)
        local next_id = 1
        for _, term in pairs(terminals) do
          if term.id >= next_id then
            next_id = term.id + 1
          end
          print("next_id is: ", next_id)
        end

        -- 执行命令：打开指定 ID 的终端，并指定方向为垂直分屏
        vim.cmd(next_id .. "ToggleTerm direction=horizontal")
      end

      -- 例如使用 Alt+v 来触发垂直分屏新终端
      vim.keymap.set('t', '<A-v>', function() vsplit_new_term() end, { noremap = true, silent = true })

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  },

  -- [Flash] 快速跳转 (2025 必备)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- [Git Signs] Git 信息提示
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup({
        current_line_blame = true, -- 开启行内 blame
      })
    end
  },

  -- [Which Key] 快捷键提示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },

  -- [Todo Comments] 高亮 TODO/FIXME
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },

  -- [Indent Blankline] 缩进参考线
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- [代码折叠] nvim-ufo (现代化折叠体验)
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufRead",
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds" },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds With" },
    },
    config = function()
      -- ufo 推荐的配置
      vim.o.foldcolumn = '1'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      require('ufo').setup({
        provider_selector = function(bufnr, filetype, buftype)
          return {'treesitter', 'indent'}
        end
      })
    end,
  },
})

-- ==========================================
-- 4. Go 语言专属自动命令
-- ==========================================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = {only = {"source.organizeImports"}}
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({async = false})
  end
})
-- ==========================================
-- 5. UI 界面美化 (诊断与图标)
-- ==========================================

vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
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
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lastplace = vim.api.nvim_create_augroup("LastPlace", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
  group = lastplace,
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 编辑器增强：格式化、终端
return {
  -- 格式化工具
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      -- 配置文件格式化
      opts.formatters_by_ft.json = { "jq" }
      opts.formatters_by_ft.yaml = { "yamlfmt" }
      opts.formatters_by_ft.lua = { "stylua" }
      opts.formatters_by_ft.sh = { "shfmt" }
      opts.formatters_by_ft.bash = { "shfmt" }
      opts.formatters_by_ft.python = { "black" }
      opts.formatters_by_ft.markdown = { "prettier" }
      
      -- TOML 和 Dockerfile 通常不需要格式化，或手动维护

      opts.format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      }
    end,
  },

  -- 终端
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    },
    opts = {
      size = 10,
      open_mapping = [[<C-\>]],
      direction = "horizontal",
      shade_terminals = true,
      start_in_insert = true,
      persist_size = true,
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)

      -- 终端模式下键位映射
      function _G.set_terminal_keymaps()
        local term_opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], term_opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], term_opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], term_opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], term_opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], term_opts)
      end

      vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
  },

  -- 文件搜索
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
  },
}

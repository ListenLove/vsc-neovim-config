-- LSP 配置：仅配置文件语言
return {
  -- Mason LSP 管理器
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- 配置文件语言
        "lua-language-server",    -- Lua (用于 nvim 配置)
        "json-lsp",               -- JSON
        "yaml-language-server",   -- YAML
        "bash-language-server",   -- Bash/Shell
        "dockerfile-language-server", -- Docker
        "pyright",                -- Python (基础支持)
      })
    end,
  },

  -- LSP 配置 - 仅配置文件类型
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Lua (用于编辑 nvim 配置)
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = "Replace" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        -- JSON 支持注释
        jsonls = {
          settings = {
            json = {
              schemas = {},
              validate = { enable = true },
            },
          },
        },
        -- YAML
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        -- Bash/Shell
        bashls = {},
        -- Dockerfile
        dockerls = {},
        -- Python (基础)
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off",
                autoImportCompletions = false,
              },
            },
          },
        },
      },
    },
  },
}

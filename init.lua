-- Dispatcher init.lua
-- 如果在 VSCode 的 vscode-neovim 插件中运行，则加载 `init_vscode.lua`（保存原有配置）
-- 否则在原生 Neovim 中加载 `init_native.lua`（新的完整配置）

local is_vscode = (vim and vim.g and vim.g.vscode) or (vim and vim.env and vim.env.VSCODE_PID ~= nil)
local config_dir = vim.fn.stdpath('config')

if is_vscode then
  local path = config_dir .. '/init_vscode.lua'
  local ok, err = pcall(dofile, path)
  if not ok then
    vim.notify('Failed to load ' .. path .. ': ' .. tostring(err), vim.log.levels.ERROR)
  end
else
  local path = config_dir .. '/init_native.lua'
  local ok, err = pcall(dofile, path)
  if not ok then
    vim.notify('Failed to load ' .. path .. ': ' .. tostring(err), vim.log.levels.ERROR)
  end
end

-- 提示当前所加载的配置（仅供调试，可删除）
vim.schedule(function()
  if is_vscode then
    vim.notify('Loaded init_vscode.lua (vscode-neovim)', vim.log.levels.INFO)
  else
    vim.notify('Loaded init_native.lua (native Neovim)', vim.log.levels.INFO)
  end
end)

-- 加载核心配置
require("core.options")
require("core.keymaps")

# VsCode × VIM
作为一个常年以 Vs Code 编辑器作为主力 IDE，同时沉醉于`神的编辑器` VIM 为 VIMer 所提供的最佳文字编辑体验的码农。在 VS Code 中辅以 VIM 的编辑体验，私以为是代码编辑的绝佳体验。既综合了 VS Code 的美观、插件生态和可定制，又兼顾了代码和文字编辑过程中以 VIM 的优雅高效.
> 由于在自己的 Vim 中配置将其配置成为 "Vs Code"的效果，从插件生态上难以达到直接使用 VS Code 的效果。所以，这次笔者从 VS Code 触发，将其配置成一个 VIM Code。

## 安装环境
1. 安装 [Neovim](https://neovim.io/)  
2. 安装 [Visual Studio Code](https://code.visualstudio.com/)  
3. 安装 [VSCode Neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) 插件：
   - 打开 VS Code，进入扩展市场（快捷键 `Ctrl+Shift+X`）
   - 搜索并安装 `VSCode Neovim` 插件
## 配置

### Windows
使用 PowerShell 安装 init.lua 配置文件

#### 备份
```powershell
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak
```



> 以下操作是可选的，但也推荐  
>
> ```powershell
> Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
> ```

#### 克隆配置文件
```powershell
git clone https://github.com/ListenLove/vsc-neovim-config  $env:LOCALAPPDATA\nvim
```

移除 .git 文件夹，这样您稍后可以将其添加到您自己的仓库中

```powershell
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force
```

### Linux/MacOS
使用终端安装 init.lua 配置文件

#### 备份
```bash
mv ~/.config/nvim{,.bak}
```
> 以下操作是可选的，但也推荐  
> ```bash
> mv ~/.local/share/nvim{,.bak}
> mv ~/.local/state/nvim{,.bak}
> mv ~/.cache/nvim{,.bak}
> ```

#### 克隆配置文件
```bash
git clone https://github.com/ListenLove/vsc-neovim-config ~/.config/nvim
```

移除 .git 文件夹，这样您稍后可以将其添加到您自己的仓库中
```bash
rm -rf ~/.config/nvim/.git
```

请注意，对于 Linux/MacOS 系统，路径和命令与 Windows PowerShell 有所不同。在 Linux/MacOS 中，Neovim 的配置文件通常位于 `~/.config/nvim` 或 `~/.local/share/nvim`，而数据文件可能位于 `~/.local/share/nvim-data`。上述命令假设您的 Neovim 配置文件位于 `~/.config/nvim`。如果您的配置文件位于不同的路径，请相应地调整命令。

## 快捷键

### VSCode 全局快捷键

在 `keybindings.json`（macOS 路径：`~/Library/Application Support/Code/User/keybindings.json`）中定义了以下编辑器标签切换快捷键：

| 快捷键 | 命令 | 说明 |
|--------|------|------|
| `Cmd+Shift+H` | `workbench.action.previousEditor` | 切换到上一个编辑器标签 |
| `Cmd+Shift+L` | `workbench.action.nextEditor` | 切换到下一个编辑器标签 |

> 如需新增或修改 VSCode 全局快捷键，可直接编辑上述 `keybindings.json` 文件，或在 VSCode 中通过 `Cmd+K Cmd+S` 打开快捷键设置界面进行操作。

### VSCode Neovim 内置快捷键

[vscode-neovim](https://marketplace.visualstudio.com/items?itemName=asvetliakov.vscode-neovim) 插件自带以下常用功能：

| 快捷键 | 说明 |
|--------|------|
| `]b` / `[b` | 切换到下一个/上一个 buffer |
| `gd` | 跳转到定义 |
| `gh` | 显示悬浮提示（类型、文档等） |
| `gb` | 跳转到同一文件中的下一个高亮符号 |
| 标准 VIM 操作 | `hjkl` 移动、数字+`hjkl` 跳转、`diw`/`ciw` 等文本对象操作、`u`/`Ctrl+r` 撤销/重做、`/`/`?` 搜索等 |

### VIM 自定义快捷键

以下快捷键在 `init_vscode.lua` 中定义，仅在 VSCode Neovim 插件的 VIM 模式下生效。

#### 窗口/窗格导航

| 快捷键 | 映射 | 说明 |
|--------|------|------|
| `<leader>h` | `<C-w>h` | 焦点移到左侧窗格 |
| `<leader>j` | `<C-w>j` | 焦点移到下方窗格 |
| `<leader>k` | `<C-w>k` | 焦点移到上方窗格 |
| `<leader>l` | `<C-w>l` | 焦点移到右侧窗格 |

> 默认 `<leader>` 键为空格（`Space`）。

#### 行内跳转

| 快捷键 | 映射 | 说明 |
|--------|------|------|
| `H` | `^` | 跳转到行首第一个非空字符 |
| `L` | `$` | 跳转到行尾 |

#### 搜索优化

| 快捷键 | 说明 |
|--------|------|
| `n` / `N` | 搜索跳转后自动居中并展开折叠 |
| `*` / `#` / `g*` / `g#` | 单词搜索跳转后自动居中并展开折叠 |
| `<Esc><Esc>` | 清除搜索高亮 |

#### 滚动优化

| 快捷键 | 映射 | 说明 |
|--------|------|------|
| `<C-f>` | `<C-f>zz` | 向下翻页后自动居中 |
| `<C-b>` | `<C-b>zz` | 向上翻页后自动居中 |

#### 剪贴板操作

| 快捷键 | 映射 | 说明 |
|--------|------|------|
| `<leader>c`（Visual） | `+"y` | 复制选中内容到系统剪贴板 |
| `<C-c>`（Visual） | `+"y` | 复制选中内容到系统剪贴板 |
| `<leader>v`（Normal） | `+"p` | 粘贴系统剪贴板内容 |
| `<leader>p`（Visual） | `"_dP` | 粘贴不覆盖已复制的文本 |

#### 其他

| 快捷键 | 映射 | 说明 |
|--------|------|------|
| `<leader>z` | `zz` | 居中当前行 |

# VsCode × VIM
作为一个常年以 Vs Code 编辑器作为主力 IDE，同时沉醉于`神的编辑器` VIM 为 VIMer 所提供的最佳文字编辑体验的码农。在 VS Code 中辅以 VIM 的编辑体验，私以为是代码编辑的绝佳体验。既综合了 VS Code 的美观、插件生态和可定制，又兼顾了代码和文字编辑过程中以 VIM 的优雅高效.
> 由于在自己的 Vim 中配置将其配置成为 "Vs Code"的效果，从插件生态上难以达到直接使用 VS Code 的效果。所以，这次笔者从 VS Code 触发，将其配置成一个 VIM Code。

## 安装环境
1.安装[Neovim](https://neovim.io/)  
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
Remove-Item $env:LOCALAPPDATA\nvim.git -Recurse -Force
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

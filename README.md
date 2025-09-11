# 💤 OurNvim.lazy

**OurNvim.lazy** is a 🔋's included Neovim configuration designed to enhance your development experience with a focus on performance, ease of use, and powerful functionality. Leveraging [Lazy.nvim](https://github.com/folke/lazy.nvim) for efficient plugin management, this setup includes a wide range of tools for LSPs, DAPs, linters, file browsing, and more!

## ✨ Features

- 🚀 **Lazy.nvim**: Efficient plugin management with lazy loading to speed up Neovim startup.
- 📦 **Mason Integration**: Simplified setup and management of LSPs, DAPs, and linters.
- 🔍 **Telescope**: Powerful fuzzy finder with numerous extensions for enhanced navigation and search.
- 🎨 **OneDark Theme**: Consistent and visually appealing interface.
- 🔌 **Rich Plugin Set**: A curated selection of plugins for improved productivity, code navigation, and user experience.

## ✅ Installation

1. **Clone the repository**:

   ```bash
   git clone --branch dirty https://github.com/GR3YH4TT3R93/OurNvim.lazy.git ~/.config/nvim
   ```

2. **Install dependencies**:
   - Ensure you have `lazy.nvim` and other required plugins set up.
   - Open Neovim and run the following command to install plugins:

     ```vim
     :LazySync
     ```

## 🛠️ Configuration

- 📂 **Adding Plugins**:
  - Navigate to `~/.config/nvim/lua/plugins` to add or configure new plugins.
  - Plugins can be added by creating new Lua files within this directory or by modifying the `init.lua` to include your custom plugin setups.

- ⌨️ **Keybindings**:
  - Update `~/.config/nvim/lua/keymaps.lua` to set your preferred keybindings.

- ⚙️ **Settings**:
  - Adjust settings in `~/.config/nvim/lua/settings.lua` to tailor the setup to your workflow.

## 🔌 Key Plugins and Features

### 📦 Mason and Extensions

- 📦 **Mason**: Manages LSPs, DAPs, and linters.
- 🛠️ **Mason-null-ls**: Integrates null-ls for linting and formatting.
- 🔗 **Mason-lspconfig**: Configures LSP servers easily.
- 🐞 **Mason-dap**: Sets up Debug Adapter Protocol support.
- 🔧 **Mason-tool-installer**: Installs tools for LSPs and DAPs.

### 🔭 Telescope and Extensions

- 🔭 **Telescope**: Advanced fuzzy finder with integrations.
  - 📋 **nvim-neoclip.lua**: Clipboard history and management.
  - 🔄 **telescope-undo.nvim**: Easy access to undo history.
  - ⚡ **telescope-fzf-native.nvim**: Faster fuzzy finding with FZF.
  - 🗂️ **smart-open.nvim**: Smart opening of files and directories.
  - 📑 **telescope-ui-select.nvim**: Enhanced selection interface.
  - 📜 **telescope-software-licenses**: Search and manage software licenses.

### 🔌 Essential Plugins

- 📁 **neotree**: File explorer with a modern UI.
- ❗ **trouble**: Diagnostics and quickfix list.
- 🔔 **noice**: Improved notification and message handling.
- ✅ **todo-comments**: Highlight and manage TODO comments.
- 🖥️ **toggleterm**: Easily toggle terminal windows.
- 🌀 **lazygit**: Git integration within Neovim.
- ✨ **multiple-cursors**: Support for multiple cursors.
- 🔄 **indent-o-matic**: Smart indentation management.
- 🔖 **nvim-ts-autotag**: Automatically manage HTML and XML tags.
- ✂️ **treesitter-textobjects**: Enhance text object manipulation with Treesitter.
- 🔚 **treesitter-endwise**: Auto-close code blocks with Treesitter.
- 📝 **nvim-ts-context-commentstring**: Context-aware comments.
- 🌈 **rainbow-delimiters**: Colorful delimiter highlighting.
- 📏 **indent-blankline**: Show indentation guides.
- 📊 **lualine**: Stylish status line.
- 🏠 **dashboard**: Neovim startup screen.

## 💻 Usage

- **Start Neovim**: Run `nvim` from your terminal.
- **Open Configuration**: Edit Neovim configuration files located in `~/.config/nvim`.

## ♻️ Contributing

We welcome contributions to improve **OurNvim.lazy**! Please feel free to:

- 🐛 Open an issue to discuss improvements or new features.
- 🔧 Fork the repository and submit a pull request with your changes.

## 📜 License

This project is licensed under the GPL-3.0 License. See the [LICENSE](LICENSE) file for more details.

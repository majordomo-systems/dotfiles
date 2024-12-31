
# LazyChode

**LazyChode** is a Neovim configuration powered by the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager. This setup aims to provide a solid, modern foundation for coding, writing, and everything in between. Below, you’ll find detailed information on installation, usage, and customization.

---

## Table of Contents

1. [Prerequisites](#prerequisites)  
2. [Installation](#installation)  
3. [Quick Start](#quick-start)  
4. [Plugin Organization](#plugin-organization)  
5. [Highlighted Plugins](#highlighted-plugins)  
   - [Core Functionality](#core-functionality)  
   - [Multi-Functional](#multi-functional)  
   - [User Interface (UI) Enhancements](#user-interface-ui-enhancements)  
   - [User Interface (Themes)](#user-interface-themes)  
   - [Editing Enhancements](#editing-enhancements)  
   - [Workflow Enhancements](#workflow-enhancements)  
   - [Markdown/Docs/Notes](#markdowndocsnotes)  
6. [Additional Tips](#additional-tips)  
7. [Contributing](#contributing)  
8. [License](#license)  

---

## Prerequisites

- **Neovim 0.8+** (ideally 0.9 or above).  
- A modern terminal that supports true color, such as [Ghostty](https://ghostty.org/) or [Alacritty](https://github.com/alacritty/alacritty).  
- (Optional) [git](https://git-scm.com/) for source control.  
- (Optional) External formatters/linters for advanced language features, if desired.

---

## Installation

1. **Backup your current config** (if you already have one):  
   ```bash
   mv ~/.config/nvim ~/.config/nvim_backup
   ```

2. **Clone LazyChode** into your Neovim config directory:
   ```bash
   git clone https://github.com/YourUserName/LazyChode.git ~/.config/nvim
   ```
   > Replace `YourUserName` with your actual GitHub username or whichever repository you’re using to store your config.

3. **Install [lazy.nvim](https://github.com/folke/lazy.nvim)** (if you haven't already):  
   ```lua
   -- A minimal example in your init.lua or lazy setup file
   local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
   if not vim.loop.fs_stat(lazypath) then
     vim.fn.system({
       "git",
       "clone",
       "--filter=blob:none",
       "https://github.com/folke/lazy.nvim.git",
       "--branch=stable", -- latest stable release
       lazypath,
     })
   end
   vim.opt.rtp:prepend(lazypath)
   ```

4. **Launch Neovim** and let `lazy.nvim` handle the plugin installation:  
   ```bash
   nvim
   ```
   Lazy should automatically install and synchronize all plugins listed in `init.lua` or the relevant Lazy config file. If not, run:
   ```vim
   :Lazy sync
   ```

---

## Quick Start

1. **Open Neovim** with your newly installed LazyChode config:  
   ```bash
   nvim path/to/some_file.lua
   ```
2. **Check the plugin status**:  
   ```vim
   :Lazy
   ```
3. **Install or update language servers** via Mason:  
   ```vim
   :Mason
   ```
4. **Start coding**! Autocomplete, linting, and formatting should work out of the box for supported languages (ensure the corresponding servers/tools are installed in `:Mason`).

---

## Plugin Organization

LazyChode’s plugin file is structured by **categories** for easy navigation:

1. **Core Functionality**  
   Basic language support, parsing, and package management for LSPs, formatters, etc.

2. **Multi-Functional**  
   Plugins that provide numerous, wide-ranging features.

3. **User Interface (UI) Enhancements**  
   Improves your workflow visually—indent guides, file explorers, status lines, buffer lines, key helpers, etc.

4. **User Interface (Themes)**  
   Color schemes that define the look of your editor.

5. **Editing Enhancements**  
   Tools for formatting, surrounding text, commenting, multi-cursor, and more.

6. **Workflow Enhancements**  
   Fuzzy finding, Git integration, session management, timers, AI code suggestions, etc.

7. **Markdown/Docs/Notes**  
   Tools for writing, previewing, and managing notes or documentation.

Each plugin is declared with its GitHub URL and relevant setup instructions in code comments.

---

## Highlighted Plugins

### Core Functionality

- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**  
  Facilitates built-in LSP support, enabling code intelligence features like autocomplete, refactoring, and documentation.  

- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)**  
  Installs and manages external tools (like language servers, linters, and formatters) in a uniform way.  

- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)**  
  Provides better syntax highlighting, indentation, and structural analysis for a wide range of languages.

### Multi-Functional

- **[folke/snacks.nvim](https://github.com/folke/snacks.nvim)**  
  A Swiss Army knife of handy features like Zen mode, scratch buffers, quick file management, Git wrappers, notifications, etc.

- **[echasnovski/mini.nvim](https://github.com/echasnovski/mini.nvim)**  
  A large collection of Lua modules for everything from UI animations to text manipulation.

### User Interface (UI) Enhancements

- **[lukas-reineke/indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)**  
  Displays vertical lines at each indentation level for better code readability.

- **[nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)**  
  A file tree explorer that replaces netrw, letting you navigate and manage files visually.

- **[akinsho/bufferline.nvim](https://github.com/akinsho/bufferline.nvim)**  
  A snazzy tab-like interface for open buffers.

- **[nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**  
  A fast, lightweight status line with plenty of customization options.

- **[folke/which-key.nvim](https://github.com/folke/which-key.nvim)**  
  Displays available keybindings in a pop-up, making it easy to discover shortcuts.

### User Interface (Themes)

- **[catppuccin/nvim](https://github.com/catppuccin/nvim)**  
  A soft pastel color scheme perfect for long coding sessions.

- **[olivercederborg/poimandres.nvim](https://github.com/olivercederborg/poimandres.nvim)**  
  A visually pleasing theme inspired by blueish tints and tranquil hues.

### Editing Enhancements

- **[stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)**  
  A code formatting manager that wires up formatters per filetype.

- **[L3MON4D3/LuaSnip](https://github.com/L3MON4D3/LuaSnip)**  
  A powerful snippet engine with extensive snippet collections.

- **[hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**  
  A complete autocompletion framework that hooks into LSP, snippets, buffers, etc.

- **[windwp/nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag)**  
  Autoclose and autorename HTML/JSX tags powered by Treesitter.

- **[kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)**  
  Easily add, change, or remove surrounding characters (quotes, brackets, etc.).

- **[numToStr/Comment.nvim](https://github.com/numToStr/Comment.nvim)**  
  A simplistic, yet robust commenting plugin.

- **[folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)**  
  Highlights, organizes, and searches `TODO`, `FIXME`, and other keywords.

- **[max397574/better-escape.nvim](https://github.com/max397574/better-escape.nvim)**  
  Map sequences like `jk` or `kj` to escape insert mode quickly.

- **[jose-elias-alvarez/null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)**  
  (Archived) Allows the use of external tools (like eslint, prettier, etc.) as if they were part of the LSP.

- **[mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi)**  
  Multi-cursor and multiple selection editing.

### Workflow Enhancements

- **[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)**  
  Extensible fuzzy finder for files, buffers, text, etc.  

- **[nvim-telescope/telescope-fzf-native.nvim](https://github.com/nvim-telescope/telescope-fzf-native.nvim)**  
  Enables blazing-fast sorting for Telescope.

- **[lewis6991/gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**  
  Displays Git changes (add, modify, remove) in the sign column.

- **[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)**  
  A full-blown Git wrapper allowing you to manage repositories without leaving Neovim.

- **[Shatur/neovim-session-manager](https://github.com/Shatur/neovim-session-manager)**  
  Saves and restores sessions for quick switching between project states.

- **[epwalsh/pomo.nvim](https://github.com/epwalsh/pomo.nvim)**  
  A pomodoro timer that integrates neatly into Neovim.

- **[yetone/avante.nvim](https://github.com/yetone/avante.nvim)**  
  AI-driven code suggestions that integrate with your existing completion pipeline.

### Markdown/Docs/Notes

- **[MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)**  
  Enhances Markdown rendering within Neovim, offering on-the-fly previews and formatting.

- **[epwalsh/obsidian.nvim](https://github.com/epwalsh/obsidian.nvim)**  
  Enables in-Neovim navigation and editing of [Obsidian](https://obsidian.md/) vaults.

---

## Additional Tips

- **Check Plugin Status**  
  Use `:Lazy` to open the lazy.nvim interface. From here, you can update plugins, clean old ones, or pin versions.

- **Install Missing Servers**  
  Run `:Mason` to manage language servers, linters, and formatters. Make sure to install everything relevant to your workflow, for example:
  ```vim
  :MasonInstall pyright black stylua prettier
  ```

- **Customize Keybindings**  
  Many plugins come with sensible defaults. You can override them in your `init.lua` or `keymaps.lua` files by mapping your own keys.

- **Use the Zen Mode**  
  Press `<leader>z` to toggle [**snacks.nvim**](https://github.com/folke/snacks.nvim) Zen Mode, which hides UI distractions.

- **Session Management**  
  Use `:SessionManager load_session` to restore a saved session. Great for quickly switching between projects!

- **Explore the Documentation**  
  Each plugin has a robust documentation. Try `:help <plugin_name>` or check the project’s GitHub page.

---

## Contributing

1. **Fork & Clone** this repository.  
2. **Branch** off `main` for any feature or bug fix.  
3. **Commit** and **push** your changes.  
4. Submit a **pull request** with a clear description of what you’ve changed.

Please feel free to open issues for bug reports, feature requests, or general questions about LazyChode.

---

## License

This configuration is open-sourced under the [MIT License](https://choosealicense.com/licenses/mit/). See the [LICENSE](./LICENSE) file for details.

---

**Enjoy LazyChode**: a curated, clean, and feature-rich Neovim setup that grows as you do. Happy hacking!

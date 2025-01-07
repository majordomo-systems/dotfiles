return {
  -- ##########################################################################################
  -- ##########################################################################################
  -- Core Functionality
  -- ##########################################################################################
  -- ##########################################################################################
  -- nvim-lspconfig - Provides core LSP support and configuration.
  -- https://github.com/neovim/nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lsp").setup_servers()
    end,
  },
  -- ##########################################################################################
  -- Mason - Manages external LSP, DAP, and formatter installations.
  -- https://github.com/williamboman/mason.nvim
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    config = function()
      require("mason").setup {
        PATH = "skip",
        ui = {
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
        max_concurrent_installers = 10,
      }

      -- Mason LSPConfig setup
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls", "pyright", "ts_ls" },
        automatic_installation = true,
      }

      -- Mason Null-LS setup
      require("mason-null-ls").setup {
        ensure_installed = { "prettier", "stylua", "eslint_d" },
        automatic_installation = true,
      }
    end,
  },
  -- ##########################################################################################
  -- Treesitter - Advanced parsing and syntax highlighting.
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    config = function()
      require("nvim-treesitter.configs").setup {
        -- List of common languages
        ensure_installed = {
          "bash",         -- Shell scripting
          "c",            -- C language
          "cpp",          -- C++
          "css",          -- CSS
          "dockerfile",   -- Dockerfiles
          "go",           -- Go language
          "html",         -- HTML
          "java",         -- Java
          "javascript",   -- JavaScript
          "json",         -- JSON
          "lua",          -- Lua
          "markdown",     -- Markdown
          "python",       -- Python
          "ruby",         -- Ruby
          "rust",         -- Rust
          "toml",         -- TOML
          "typescript",   -- TypeScript
          "vim",          -- VimScript
          "yaml",         -- YAML
        },
        highlight = {
          enable = true, -- Enable syntax highlighting
        },
        indent = {
          enable = true, -- Enable Treesitter-based indentation
        },
      }
    end,
  },
  -- ##########################################################################################
  -- Legendary -  Keymaps, commands, and autocommands as Lua tables, building a legend at the same time.
  -- https://github.com/mrjones2014/legendary.nvim
  {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frequency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
  -- ##########################################################################################
  -- ##########################################################################################
  -- Multi Functional
  -- ##########################################################################################
  -- ##########################################################################################
  -- snacks.nvim - A collection of small QoL plugins for Neovim.
  -- https://github.com/folke/snacks.nvim
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
      { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          })
        end,
      }
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
          Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
          Snacks.toggle.diagnostics():map("<leader>ud")
          Snacks.toggle.line_number():map("<leader>ul")
          Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
          Snacks.toggle.treesitter():map("<leader>uT")
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
          Snacks.toggle.inlay_hints():map("<leader>uh")
          Snacks.toggle.indent():map("<leader>ug")
          Snacks.toggle.dim():map("<leader>uD")
        end,
      })
    end,
  },
  -- ##########################################################################################
  -- mini.nvim - Library of 40+ independent Lua modules.
  -- https://github.com/echasnovski/mini.nvim
  {
    "echasnovski/mini.nvim",
    version = false,
    config = function()
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.animate").setup()
      require("mini.basics").setup()
      require("mini.comment").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
    end,
  },
  -- ##########################################################################################
  -- ##########################################################################################
  -- User Interface (UI Enhancements)
  -- ##########################################################################################
  -- ##########################################################################################
  -- Indent Blankline - Adds indentation guides to Neovim.
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false, -- Load it during startup
    config = function()
      require("ibl").setup({
        indent = {
          char = "▏", -- The character for indent lines
        },
        exclude = {
          filetypes = { "help", "dashboard", "NvimTree", "packer" }, -- Exclude specific filetypes
          buftypes = { "terminal", "nofile" }, -- Exclude specific buffer types
        },
      })
    end,
  },
  -- ##########################################################################################
  -- NvimTree - File Explorer
  -- https://github.com/nvim-tree/nvim-tree.lua
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   lazy = false,
  --   dependencies = { "nvim-tree/nvim-web-devicons" },
  --   config = function()
  --     require("nvim-tree").setup {
  --       view = {
  --         side = "right",
  --         signcolumn = "no",
  --       },
  --     }
  --   end,
  -- },
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- Keymap to toggle the file explorer
      vim.cmd([[
        nnoremap - :NvimTreeToggle<CR>
      ]])

      -- Disable netrw
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      -- Use terminal colors
      vim.opt.termguicolors = true

      -- Ratios for floating window geometry
      local HEIGHT_RATIO = 0.8  -- Adjust for your preference
      local WIDTH_RATIO  = 0.75  -- Adjust for your preference

      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        respect_buf_cwd = true,
        sync_root_with_cwd = true,
        view = {
          relativenumber = true,
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.opt.columns:get()
              local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
              local window_w = screen_w * WIDTH_RATIO
              local window_h = screen_h * HEIGHT_RATIO
              local window_w_int = math.floor(window_w)
              local window_h_int = math.floor(window_h)
              local center_x = (screen_w - window_w) / 2
              local center_y = ((vim.opt.lines:get() - window_h) / 2)
                               - vim.opt.cmdheight:get()
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
          width = function()
            return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
          end,
        },
        -- Example of other optional config:
        -- filters = { custom = { "^.git$" } },
        -- renderer = { indent_width = 1 },
      })
    end,
  },
  -- ##########################################################################################
  -- Bufferline - Tabs-like Buffer Management
  -- https://github.com/akinsho/bufferline.nvim
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup()
    end,
  },
  -- ##########################################################################################
  -- Lualine - Status line with theming options.
  -- https://github.com/nvim-lualine/lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          theme = "poimandres",
          section_separators = { left = "", right = "" },
          -- component_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } }, -- Full file path
          lualine_x = { "encoding", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },
  -- ##########################################################################################
  -- Noice - Plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  -- https://github.com/folke/noice.nvim?tab=readme-ov-file
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      })
    end,
  },
  -- ##########################################################################################
  -- Which-Key - Pop-up helper for keybindings.
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup()
    end,
  },
  -- ##########################################################################################
  -- ##########################################################################################
  -- User Interface (Themes)
  -- ##########################################################################################
  -- ##########################################################################################
  -- Catppuccin for (Neo)vim
  -- https://github.com/catppuccin/nvim
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- ##########################################################################################
  -- Poimandres for (Neo)vim
  -- https://github.com/olivercederborg/poimandres.nvim
  {
    'olivercederborg/poimandres.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('poimandres').setup {
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
        bold_vert_split = false, -- use bold vertical separators
        dim_nc_background = false, -- dim 'non-current' window backgrounds
        disable_background = false, -- disable background
        disable_float_background = false, -- disable background for floats
        disable_italics = false, -- disable italics
      }
    end,
    -- optionally set the colorscheme within lazy config
    init = function()
      vim.cmd("colorscheme poimandres")
    end
  },
  -- ##########################################################################################
  -- Poimandres for (Neo)vim
  -- https://github.com/guruguhangunaratnam/retro_green.nvim
  -- {
  --   'guruguhangunaratnam/retro_green.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('poimandres').setup {
  --       -- leave this setup function empty for default config
  --       -- or refer to the configuration section
  --       -- for configuration options
  --       bold_vert_split = false, -- use bold vertical separators
  --       dim_nc_background = false, -- dim 'non-current' window backgrounds
  --       disable_background = false, -- disable background
  --       disable_float_background = false, -- disable background for floats
  --       disable_italics = false, -- disable italics
  --     }
  --   end,
  --   -- optionally set the colorscheme within lazy config
  --   init = function()
  --     vim.cmd("colorscheme poimandres")
  --   end
  -- },
  -- ##########################################################################################
  -- Tundra for (Neo)vim
  -- https://github.com/sam4llis/nvim-tundra?tab=readme-ov-file
  {
    'sam4llis/nvim-tundra',
    lazy = false,
    priority = 1000,
    config = function()
      require('nvim-tundra').setup({
        transparent_background = false,
        dim_inactive_windows = {
          enabled = false,
          color = nil,
        },
        sidebars = {
          enabled = true,
          color = nil,
        },
        editor = {
          search = {},
          substitute = {},
        },
        syntax = {
          booleans = { bold = true, italic = true },
          comments = { bold = true, italic = true },
          conditionals = {},
          constants = { bold = true },
          fields = {},
          functions = {},
          keywords = {},
          loops = {},
          numbers = { bold = true },
          operators = { bold = true },
          punctuation = {},
          strings = {},
          types = { italic = true },
        },
        diagnostics = {
          errors = {},
          warnings = {},
          information = {},
          hints = {},
        },
        plugins = {
          lsp = true,
          semantic_tokens = true,
          treesitter = true,
          telescope = true,
          nvimtree = true,
          cmp = true,
          context = true,
          dbui = true,
          gitsigns = true,
          neogit = true,
          textfsm = true,
        },
        overwrite = {
          colors = {},
          highlights = {},
        },
      })

    end,
    -- init = function()
    --   vim.g.tundra_biome = 'arctic' -- 'arctic' or 'jungle'
    --   vim.opt.background = 'dark'
    --   vim.cmd('colorscheme tundra')
    -- end
  },
  -- ##########################################################################################
  -- ##########################################################################################
  -- Editing Enhancements
  -- ##########################################################################################
  -- ##########################################################################################
  -- Conform - Code formatting manager.
  -- https://github.com/stevearc/conform.nvim
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        markdown = { "prettier" },
      },
    },
  },
  -- ##########################################################################################
  -- LuaSnip - Snippet engine and collection.
  -- https://github.com/L3MON4D3/LuaSnip
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- Load snippets in VSCode format
      require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
      require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

      -- Load snippets in SnipMate format
      require("luasnip.loaders.from_snipmate").load()
      require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

      -- Load snippets in Lua format
      require("luasnip.loaders.from_lua").load()
      require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }

      -- Autocmd to clear snippets on leaving insert mode
      vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
          if
            require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
            and not require("luasnip").session.jump_active
          then
            require("luasnip").unlink_current()
          end
        end,
      })
    end,
  },
  -- ##########################################################################################
  -- nvim-cmp - Autocompletion framework.
  -- https://github.com/hrsh7th/nvim-cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup {
        completion = { completeopt = "menu,menuone" },

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),

          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "nvim_lua" },
          { name = "path" },
        },
      }
    end,
  },
  -- ##########################################################################################
  -- Auto-closing and auto-renaming of HTML/JSX tags using Treesitter.
  -- https://github.com/windwp/nvim-ts-autotag
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- ##########################################################################################
  -- ToDo Comments - Highlights and organizes TODO comments.
  -- https://github.com/folke/todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    lazy = false,
    config = function()
      require("todo-comments").setup()
    end,
  },
  -- ##########################################################################################
  -- Better Escape - Improves the escape mechanism from insert mode.
  -- https://github.com/max397574/better-escape.nvim
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup {
        mapping = { "jk", "kj" },
      }
    end,
  },
  -- ##########################################################################################
  -- Null-ls - Extends LSP features (formatting, linting) with external tools. [ARCHIVED PROJECT]
  -- https://github.com/jose-elias-alvarez/null-ls.nvim
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      -- Setup null-ls
      null_ls.setup({
        sources = {
          -- Add StyLua for Lua formatting
          null_ls.builtins.formatting.stylua.with({
            extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/.stylua.toml") },
          }),
          -- Add more formatters/linters as needed
        },
        on_attach = function(client, bufnr)
          -- Format on save
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = vim.api.nvim_create_augroup("LspFormatting", {}),
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
      })
    end,
  },
  -- ##########################################################################################
  -- vim-visual-multi - Multiple cursor/selection editing.
  -- https://github.com/mg979/vim-visual-multi
  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<c-n>"
      }
    end,
  },
  -- ##########################################################################################
  -- ##########################################################################################
  -- Workflow Enhancements
  -- ##########################################################################################
  -- ##########################################################################################
  -- Telescope - Fuzzy finder to quickly locate files, text, etc.
  -- https://github.com/nvim-telescope/telescope.nvim
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require("telescope").setup {
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
          },
        },
      }
      -- Load the fzf extension
      require("telescope").load_extension("fzf")
    end,
  },
  -- ##########################################################################################
  -- FZF extension for Telescope.
  -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = { "nvim-telescope/telescope.nvim" },
  },
  -- ##########################################################################################
  -- Git Signs - Git signs in the gutter (add/change/delete).
  -- https://github.com/lewis6991/gitsigns.nvim
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup {
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "󰍵" },        -- Custom delete sign
          changedelete = { text = "󱕖" }, -- Custom change/delete sign
        },
      }
    end,
  },
  -- ##########################################################################################
  -- Vim Fugitive - Powerful Git integration within Neovim.
  -- https://github.com/tpope/vim-fugitive
  {
    "tpope/vim-fugitive",
  },
  -- ##########################################################################################
  -- Session management for restoring open buffers, windows, etc.
  -- https://github.com/Shatur/neovim-session-manager
  {
    "Shatur/neovim-session-manager",
    config = function()
      local Path = require("plenary.path")
      local config = require("session_manager.config")
      require("session_manager").setup {
        sessions_dir = Path:new(vim.fn.stdpath("data"), "sessions"),
        autoload_mode = config.AutoloadMode.Disabled, -- Disable automatic session loading
      }
    end,
  },
  -- ##########################################################################################
  -- pomo.nvim - A simple, customizable pomodoro timer.
  -- https://github.com/epwalsh/pomo.nvim
  {
    "epwalsh/pomo.nvim",
    version = "*",  -- Recommended, use latest release instead of latest commit
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat", "TimerSession" },
    dependencies = {
      -- Optional, but highly recommended if you want to use the "Default" timer
      "rcarriga/nvim-notify",
    },
    opts = {
      -- See below for full list of options 👇
    },
  },
  -- ##########################################################################################
  -- avante.nvim - AI-driven code suggestions.
  -- https://github.com/yetone/avante.nvim
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  -- ##########################################################################################
  -- ##########################################################################################
  -- Workflow Enhancements
  -- ##########################################################################################
  -- ##########################################################################################
  -- render-markdown.nvim - Improve viewing Markdown files in Neovim
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- ##########################################################################################
  -- obsidian.nvim - For writing and navigating Obsidian vaults.
  -- https://github.com/epwalsh/obsidian.nvim
  {
    "epwalsh/obsidian.nvim",
    version = "*",  -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/vaults/personal",
        },
        {
          name = "work",
          path = "~/vaults/work",
        },
      },

      -- see below for full list of options 👇
    },
  },
  -- ##########################################################################################
}
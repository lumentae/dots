return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    opts = {
      diagnostics = {
        update_in_insert = true,
      },
    },
  },

  {
    "wakatime/vim-wakatime",
    lazy = false,
  },

  {
    "andweeb/presence.nvim",
    lazy = false,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {},
  },

  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-mini/mini.icons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
    lazy = false,
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "bashls", -- bash-language-server
        "cmake", -- cmake-language-server
        "clangd", -- cpptools
        "csharp_ls", -- csharp-language-server
        "dockerls", -- docker-language-server
        "docker_compose_language_service", -- docker-compose-language-service
        "fish_lsp", -- fish-lsp
        "glsl_analyzer", -- glsl_analyzer
        "html", -- html-lsp
        "jsonls", -- json-lsp
        "lua_ls", -- luau-lsp / lua-lsp variant
        "nginx_language_server", -- nginx-language-server
        "phpactor", -- phpactor
        "pylsp", -- python-lsp-server
        "tailwindcss", -- tailwindcss-language-server
        "ts_ls", -- typescript-language-server
        "yamlls", -- yaml-language-server
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    lazy = false,
  },

  {
    "Civitasv/cmake-tools.nvim",
    opts = {},
    lazy = true,
  },

  {
    import = "nvchad.blink.lazyspec",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "asm",
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "css",
        "csv",
        "dockerfile",
        "fish",
        "glsl",
        "hlsl",
        "html",
        "java",
        "json",
        "json5",
        "lua",
        "make",
        "php",
        "python",
        "tsx",
        "typescript",
        "xml",
        "yaml",
      },
    },
  },
}

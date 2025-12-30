return {
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
}

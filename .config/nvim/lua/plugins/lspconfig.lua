return {
  "neovim/nvim-lspconfig",
  config = function()
    require "configs.lspconfig"
  end,
  opts = {
    diagnostics = {
      update_in_insert = true,
    },
  },
}

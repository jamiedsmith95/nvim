return {
  -- 1. Re-enable the official LazyVim Haskell extra spec
  { import = "lazyvim.plugins.extras.lang.haskell" },

  -- 2. Configure haskell-tools specifically for Nix
  {
    "mrcjkb/haskell-tools.nvim",
    version = false,
    -- haskell-tools uses a global global configuration table instead of standard opts lifecycle
    config = function()
      vim.g.haskell_tools = {
        hls = {
          -- Correctly force haskell-tools to execute the native binary
          cmd = { "haskell-language-server", "--lsp" },
          -- Overwrite its internally managed mason toggle
          mason = false,
          -- Let your strict hie.yaml layout guide file-system lookups
          root_dir = require("lspconfig.util").root_pattern("cabal.project", "*.cabal", "hie.yaml", ".git"),
          settings = {
            haskell = {
              checkProject = true,
            },
          },
        },
      }
    end,
  },
}

local status_ok_0, dap = pcall(require, "nvim-dap")
if not status_ok then
  return
end
local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end
local servers = {
  -- "cssls",
  "cssmodules_ls",
  "emmet_ls",
  "html",
  -- "cssmodules_language_server",
  "jdtls",
  "jsonls",
  "solc",
  "lua_ls",
  "lua-language-server",
  "html",
  "tflint",
  "terraformls",
  "tsserver",
  "gopls",
--  "pyright",
  "yamlls",
  "bashls",
  "clangd",
  "rust_analyzer",
  -- "rust-tools",
  "taplo",
  "zk@v0.10.1",
  "lemminx"
}

local settings = {
  ui = {
    border = "rounded",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}
mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end
local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("jamie.lsp.handlers").on_attach,
    capabilities = require("jamie.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]

--  if server == "jsonls" then
   -- local jsonls_opts = require "jamie.lsp.settings.jsonls"
--    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
 -- end

  if server == "yamlls" then
    local yamlls_opts = require "jamie.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "emmet_ls" then
    local emmet_opts = require "jamie.lsp.settings.emmet"
    opts = vim.tbl_deep_extend("force", emmet_opts, opts)
  end

  -- if server == "css_lsp" then
  --   local csslps_opts = require "jamie.lsp.settings.csslsp"
  --   opts = vim.tbl_deep_extend("force", csslsp_opts, opts)
  -- end
  if server == "lua-language-server" then
    local luals_opts = require "jamie.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", luals_opts, opts)
  end
  if server == "lua_ls" then
    local luals_opts = require "jamie.lsp.settings.sumneko_lua"
    opts = vim.tbl_deep_extend("force", luals_opts, opts)
  end

  if server == "cssmodules_ls" then
    local cssmod_opts = require "jamie.lsp.settings.cssmod"
    opts = vim.tbl_deep_extend("force", cssmod_opts, opts)
  end

  if server == "lua-language-server" then
    local l_status_ok, lua_dev = pcall(require, lua-dev)
    if not l_status_ok then
      return
    end
    -- local sumneko_opts = require "jamie.lsp.settings.lua_ls"
    -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = lua_dev.setup {
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig.lua_ls.setup(luadev)
    goto continue
  end

  if server == "tsserver" then
    local tsserver_opts = require "jamie.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "gopls" then
    local goopts = require "jamie.lsp.settings.goopts"
    opts = vim.tbl_deep_extend("force", goopts, opts)
  end

  if server == "kotlin-language-server" then
    local kotlin_opts = require "jamie.lsp.settings.kotlin"
    opts = vim.tbl_deep_extend("force", kotlin_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "jamie.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "solc" then
    local solc_opts = require "jamie.lsp.settings.solc"
    opts = vim.tbl_deep_extend("force", solc_opts, opts)
  end


  if server == "zk" then
    local zk_opts = require "jamie.lsp.settings.zk"
    opts = vim.tbl_deep_extend("force", zk_opts, opts)
  end

  if server == "jdtls" then
    goto continue
  end

  if server == "rust_analyzer" then
    local rust_opts = require "jamie.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}

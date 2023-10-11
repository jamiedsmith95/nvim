local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	--  return
	print("null_ls not found.")
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			extra_filetypes = { "toml", "solidity" },
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.shfmt,
		formatting.google_java_format,
		diagnostics.flake8,
		--diagnostics.shellcheck,
	},
})

-- local unwrap = {
--   method = null_ls.methods.DIAGNOSTICS,
--   filetypes = { "rust" },
--   generator = {
--     fn = function(params)
--       local diagnostics = {}
--       -- sources have access to a params object
--       -- containing info about the current file and editor state
--       for i, line in ipairs(params.content) do
--         local col, end_col = line:find "unwrap()"
--         if col and end_col then
--           -- null-ls fills in undefined positions
--           -- and converts source diagnostics into the required format
--           table.insert(diagnostics, {
--             row = i,
--             col = col,
--             end_col = end_col,
--             source = "unwrap",
--             message = "hey " .. os.getenv("USER") .. ", don't forget to handle this" ,
--             severity = 2,
--           })
--         end
--       end
--       return diagnostics
--     end,
--   },
-- }

local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")

local markdownlint = {
    method = null_ls.methods.DIAGNOSTICS,
    filetypes = { "markdown" },
    -- null_ls.generator creates an async source
    -- that spawns the command with the given arguments and options
    generator = null_ls.generator({
        command = "markdownlint",
        args = { "--stdin" },
        to_stdin = true,
        from_stderr = true,
        -- choose an output format (raw, json, or line)
        format = "line",
        check_exit_code = function(code, stderr)
            local success = code <= 1

            if not success then
                -- can be noisy for things that run often (e.g. diagnostics), but can
                -- be useful for things that run on demand (e.g. formatting)
                print(stderr)
            end

            return success
        end,
        -- use helpers to parse the output from string matchers,
        -- or parse it manually with a function
        on_output = helpers.diagnostics.from_patterns({
            {
                pattern = [[:(%d+):(%d+) [%w-/]+ (.*)]],
                groups = { "row", "col", "message" },
            },
            {
                pattern = [[:(%d+) [%w-/]+ (.*)]],
                groups = { "row", "message" },
            },
        }),
    }),
}

null_ls.register(markdownlint)
-- null_ls.register(unwrap)

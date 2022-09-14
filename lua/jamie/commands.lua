vim.api.nvim_create_autocmd("BufWriteCmd", {
        group = vim.api.nvim_create_augroup("thisgroup", { clear = true }),
        pattern = "*",
--        callback = function()
                  vim.cmd("write")
                  -- vim.cmd("Remws")
                  vim.cmd("write")
 --       end,

}


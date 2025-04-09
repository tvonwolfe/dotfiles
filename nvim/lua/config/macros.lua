local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)

-- take the currently-selected expression and print it with console.log
vim.api.nvim_create_augroup("JSLogMacro", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "JSLogMacro",
  pattern = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  },
  callback = function()
    vim.fn.setreg("l", "yoconsole.log('" .. esc .. "pa:" .. esc .. "la, " .. esc .. "pl")
  end
})

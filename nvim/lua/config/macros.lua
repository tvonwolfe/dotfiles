local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)
local space = vim.api.nvim_replace_termcodes('<Space>', true, true, true)

-- take the currently-selected expression and print it to the console
local group = "ConsoleLogMacro"
vim.api.nvim_create_augroup(group, { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
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

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = {
    "ruby"
  },
  callback = function()
    vim.fn.setreg("l", "yoRails.logger.info(\"" .. esc .. "pa:" .. space .. esc .. "a#{" .. esc .. "pl")
  end
})

return {
  cmd = { "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { ".git", "Gemfile" },
  init_options = {
    formatter = "standard",
    linters = { "standard" },
    on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, { noremap = true, silent = true })
      client.commands = client.commands or {}

      client.commands['rubyLsp.openFile'] = function(command)
        local file_path = command.arguments[1][1]

        local path, line = string.match(file_path, '(.+)#L(%d+)')
        path = path or file_path -- if no line number, use the whole path

        path = string.gsub(path, 'file://', '')
        vim.cmd('edit ' .. path)

        if line then
          vim.cmd(line)
        end
      end
    end,
  }
}

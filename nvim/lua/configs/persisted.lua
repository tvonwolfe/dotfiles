local persisted_ok, persisted = pcall(require, 'persisted')
if not persisted_ok then return end

persisted.setup {
  autoload = true,
  use_git_branch = true
}

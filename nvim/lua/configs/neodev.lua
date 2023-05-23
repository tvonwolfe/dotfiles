local neodev_status_ok, neodev = pcall(require, 'neodev')

if neodev_status_ok then
  neodev.setup()
end

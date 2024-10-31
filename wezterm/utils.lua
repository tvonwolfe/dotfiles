local merge_tables = function(...)
  local tables = { ... }
  local result = {}
  for _, t in ipairs(tables) do
    for k, v in pairs(t) do
      result[k] = v
    end
  end
  return result
end

local get_os = function()
  local os_name = io.popen('uname -s', 'r'):read('*l')
  return string.lower(os_name)
end

return {
  merge_tables = merge_tables,
  get_os = get_os,
}

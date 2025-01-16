return {
  'dnlhc/glance.nvim',
  lazy = true,
  opts = {
    hooks = {
      before_open = function(results, open, jump, method)
        if #results == 1 then
          jump(results[1])
        else
          open(results)
        end
      end,
    },
  },
}

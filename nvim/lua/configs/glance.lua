local glance = require('glance')

glance.setup({
  hooks = {
    before_open = function(results, open, jump, method)
      if #results == 1 then
        jump(results[1])
      else
        open(results)
      end
    end,
  },
})

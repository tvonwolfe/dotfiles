return {
  'rcarriga/nvim-notify',
  init = function()
    local notify_ok, notify = pcall(require, 'notify')
    if not notify_ok then return end


    local banned_messages = {
      'No information available',
    }
    local function is_message_banned(message)
      for _, banned in ipairs(banned_messages) do
        if message == banned then
          return true
        end
      end

      return false
    end

    vim.notify = function(msg, ...)
      if is_message_banned(msg) then return end
      return notify(msg, ...)
    end
  end
}

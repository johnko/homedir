local terminalswitcher = {}

terminalswitcher.logger = hs.logger.new("terminalswitcher")

terminalswitcher.switch = function(input)

  local suffix = input .. ""

  terminalswitcher.application = hs.application.find('com.apple.Terminal')
  if terminalswitcher.application ~= nil then

    local window = terminalswitcher.application:findWindow('.*⌥⌘' .. suffix)
    if window ~= nil then

      terminalswitcher.logger.f("title %s", window:title())
      window:focus()

    end

  end

end

return terminalswitcher

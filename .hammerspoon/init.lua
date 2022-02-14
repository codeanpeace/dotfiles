meta = {"ctrl", "alt", "cmd"}
metashift = {"ctrl", "alt", "cmd", "shift"}

hyper = {"ctrl", "cmd"}
hypershift = {"ctrl", "cmd", "shift"}

require("watcher")
require("position")
-- require("super")

-----------------------------------------------
-- Hyper Spoon (wip)
-- https://github.com/evantravers/Hyper.spoon
-----------------------------------------------
hyperConfig = {
  applications = {
    -- hs.application.infoForBundlePath("/Applications/iTerm.app")["CFBundleIdentifier"])
    ['com.apple.iterm2'] = {
      bundleID = 'com.googlecode.iterm2',
      hyperKey = 't',
      localBindings = {'a', 'z'}
      -- local bindings send cmd + alt + ctrl + shift + key
    }
  }
}
hs.loadSpoon('Hyper')
spoon.Hyper:start(hyperConfig):setHyperKey('F20')
-- caps lock is set to F20 as modifier via Karabiner, consider changing to chord led by "a"

spoon.Hyper:bind({}, 'r', nil, function()
  hs.application.launchOrFocusByBundleID('org.hammerspoon.Hammerspoon')
end)

-- Jump to google hangout or zoom
-- Hyper:bind({}, 'z', nil, function()
--   if hs.application.find('us.zoom.xos') then
--     hs.application.launchOrFocusByBundleID('us.zoom.xos')
--   elseif hs.application.find('com.microsoft.teams') then
--     spoon.Teamz.callWindow():focus()
--   else
--     brave.jump("meet.google.com|hangouts.google.com.call")
--   end
-- end)

-- params: mods, key, message, pressedfn, releasedfn, repeatfn
-- HyperSpoon:bind({}, 'return', nil, autolayout.autoLayout)
-- HyperSpoon:bind({'shift'}, 'r', nil, function() hs.reload() end)
-- or -- spoon.Hyper:bind()

-----------------------------------------------
-- MicMute spoon
-- toggle mic or push to chat
-----------------------------------------------
hs.loadSpoon("MicMute")
spoon.MicMute:bindHotkeys({toggle = {hypershift, "m"}}, 0.75)

-----------------------------------------------
-- KSheet spoon
-- show keyboard shortcuts for current app
-----------------------------------------------
hs.loadSpoon("KSheet")
spoon.KSheet:bindHotkeys({toggle = {hyper, "k"}})

-----------------------------------------------
-- WindowSigils spoon
-- show sigil window hints in titlebars
-----------------------------------------------
local function focus_window(window)
  window:focus()
  if hs.window.focusedWindow() ~= window then
    window:focus()
  end
end

local function swap_window(window)
  local focused_frame = hs.window.focusedWindow():frame()
  local selected_frame = window:frame()
  hs.window.focusedWindow():setFrame(selected_frame, 0)
  window:setFrame(focused_frame, 0)
end

sigils = hs.loadSpoon("WindowSigils")
sigils:configure({
  hotkeys = {
    enter = {hypershift, "s"}
  },
  mode_keys = {
    -- [{{'shift'}, 'i'}] = ignore_notification,
    -- [{{}, 'v'}]        = paste_as_keystrokes,
    -- [{{}, ','}]        = rerun_last_command,
  },
  sigil_actions = {
    [{}]       = focus_window,
    [{'ctrl'}] = swap_window,
    -- [{'alt'}]  = warp_window,
  }
})
-- sigils:start()

-----------------------------------------------
-- Miscellaneous
-----------------------------------------------
-- paste through keyboard events (defeat paste blocking)
hs.hotkey.bind(hyper, "V", function() hs.eventtap.keyStrokes(hs.pasteboard.getContents()) end)

-----------------------------------------------
-- Multi monitor
-- Move Next / Previous Screen
-----------------------------------------------

hs.hotkey.bind(hyper, hs.keycodes.map["["], hs.grid.pushWindowPrevScreen)
hs.hotkey.bind(hyper, hs.keycodes.map["]"], hs.grid.pushWindowNextScreen)
-- hs.hotkey.bind(hyper, "m", hs.grid.pushWindowNextScreen)
-- hs.hotkey.bind(hyper, "n", hs.grid.pushWindowNextScreen)
-- hs.hotkey.bind(hyper, "p", hs.grid.pushWindowPrevScreen)

-----------------------------------------------
-- Multi spaces
-- Move Next / Previous Space
-----------------------------------------------
-- note: wrong architecture when installing hs._asm.undocumented.spaces

-- hs.loadSpoon("MoveSpaces")
-- spoon.MoveSpaces.bindHotkeys({
-- 	space_right = {{"ctrl", "alt"}, "l"},
--     space_left = {{"ctrl", "alt"}, "h"}
-- })

-----------------------------------------------
-- cmd - ctrl - w to show window hints
-- cmd - ctrl - shift - w to show application window hints
-----------------------------------------------

hs.hints.showTitleThresh = 50

hs.hotkey.bind(hyper, "h", function()
  hs.hints.windowHints()
end)

hs.hotkey.bind(hypershift, "h", function()
  hs.hints.windowHints(hs.window.focusedWindow():application():allWindows())
end)

-----------------------------------------------
-- cmd - ctrl - e to show window expose with hints
-- cmd - ctrl - shift - e to show application window expose with hints
-----------------------------------------------
-- set up your instance(s)
-- expose = hs.expose.new(nil,{showThumbnails=false}) -- default windowfilter, no thumbnails
-- expose = hs.expose.new(nil,{showThumbnails=true}) -- default windowfilter, no thumbnails

local wf=hs.window.filter
blacklist_wf=wf.new(false):setAppFilter('Contexts',false) -- exclude hidden Contexts panel

expose = hs.expose.new(blacklist_wf,{showThumbnails=true}) -- blacklist windowfilter, with thumbnails
expose_app = hs.expose.new(nil,{onlyActiveApplication=true}) -- show windows for the current application
expose_space = hs.expose.new(nil,{includeOtherSpaces=false}) -- only windows in the current Mission Control Space
expose_browsers = hs.expose.new{'Safari','Google Chrome', 'Firefox'} -- specialized expose using a custom windowfilter
-- for your dozens of browser windows :)

-- then bind to a hotkey
-- hs.hotkey.bind('ctrl-cmd','e','Expose',function()expose:toggleShow()end)
-- hs.hotkey.bind('ctrl-cmd-shift','e','App Expose',function()expose_app:toggleShow()end)
-- hs.hotkey.bind('ctrl-cmd','e','App Expose',function()expose_app:toggleShow()end)

hs.hotkey.bind(hyper,'e','Expose',function()expose:toggleShow()end)
hs.hotkey.bind(hypershift,'e','App Expose',function()expose_app:toggleShow()end)

-----------------------------------------------
-- reacting to wifi events
-----------------------------------------------
local wifiWatcher = nil
local homeSSID = "MyHomeNetwork"
local lastSSID = hs.wifi.currentNetwork()

function ssidChangedCallback()
    newSSID = hs.wifi.currentNetwork()

    if newSSID == homeSSID and lastSSID ~= homeSSID then
        -- We just joined our home WiFi network
        -- hs.audiodevice.defaultOutputDevice():setVolume(25)
    elseif newSSID ~= homeSSID and lastSSID == homeSSID then
        -- We just departed our home WiFi network
        -- hs.audiodevice.defaultOutputDevice():setVolume(0)
    end

    lastSSID = newSSID
end

wifiWatcher = hs.wifi.watcher.new(ssidChangedCallback)
wifiWatcher:start()

-- run applescript
-- ok,result = hs.applescript('tell Application "iTunes" to artist of the current track as string')
-- hs.alert.show(result)

-- hs.messages.iMessage("+mobile", "hammerspoon hello world")
-- hs.messages.iMessage("some@email.com", "hammerspoon hello world")

-- hs.urlevent.bind("someAlert", function(eventName, params)
--   hs.alert.show("Received someAlert")
-- end)
-- open -g hammerspoon://someAlert

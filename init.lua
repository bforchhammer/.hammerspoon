hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("ReloadConfiguration", {start=true})

hs.window.animationDuration = 0.1

local hyper = {"ctrl", "alt", "cmd"}
spoon.SpoonInstall:andUse("MiroWindowsManager", {hotkeys={
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
}})

local spacesKey = {"cmd", "ctrl"}
--spoon.SpoonInstall:andUse("MoveSpaces", {hotkeys={
--  space_left = {spacesKey, "left"},
--  space_right = {spacesKey, "right"}
--}})

spoon.SpoonInstall:andUse("HeadphoneAutoPause", {})


-- set up your windowfilter
-- switcher = hs.window.switcher.new(hs.window.filter.new():setDefaultFilter{}) -- include minimized/hidden windows, current Space only
-- hs.hotkey.bind('alt','tab','Next window',function()switcher:next()end)
-- hs.hotkey.bind('alt-shift','tab','Prev window',function()switcher:previous()end)


hs.notify.new({title="Hammerspoon", informativeText="Configuration reloaded"}):send()

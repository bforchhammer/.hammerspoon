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

local spaces = require("hs._asm.undocumented.spaces")
function MoveWindowToSpace(sp)
    local win = hs.window.focusedWindow()      -- current window
    local uuid = win:screen():spacesUUID()     -- uuid for current screen
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
    spaces.changeToSpace(spaceID)              -- follow window to new space
end

local moveSpacesKey = {"ctrl", "shift"}
hs.hotkey.bind(moveSpacesKey, '1', function() MoveWindowToSpace(1) end)
hs.hotkey.bind(moveSpacesKey, '2', function() MoveWindowToSpace(2) end)
hs.hotkey.bind(moveSpacesKey, '3', function() MoveWindowToSpace(3) end)
hs.hotkey.bind(moveSpacesKey, '4', function() MoveWindowToSpace(4) end)
hs.hotkey.bind(moveSpacesKey, '5', function() MoveWindowToSpace(5) end)
hs.hotkey.bind(moveSpacesKey, '6', function() MoveWindowToSpace(6) end)
hs.hotkey.bind(moveSpacesKey, '7', function() MoveWindowToSpace(7) end)
hs.hotkey.bind(moveSpacesKey, '8', function() MoveWindowToSpace(8) end)
hs.hotkey.bind(moveSpacesKey, '9', function() MoveWindowToSpace(9) end)

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

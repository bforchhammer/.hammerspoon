hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("ReloadConfiguration", {start=true})

hs.window.animationDuration = 0.1

-- Keyboard shortcuts for window sizing
local hyper = {"ctrl", "alt", "cmd"}
spoon.SpoonInstall:andUse("MiroWindowsManager", {hotkeys={
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
}})

-- Menubar widget to show active spaces; updates on a timer
local spaceiconsUpdateInterval = 1
local spaceicons = hs.menubar.new()

function UpdateSpacesIcon()
    local activeSpaces = hs.spaces.activeSpaces()
    local icons = ""
    for screenId, screenSpaces in pairs(hs.spaces.allSpaces()) do
	for spaceIdx, spaceId in pairs(screenSpaces) do
	    if hs.fnutils.contains(activeSpaces, spaceId) then
		icons = icons .. "🔳"
            else
                icons = icons .. "⬜"
            end
	end
	icons = icons .. " "
    end
    spaceicons:setTitle(icons)
end
local UpdateSpacesIconTimer = hs.timer.doEvery(spaceiconsUpdateInterval, function() UpdateSpacesIcon() end)
UpdateSpacesIconTimer:fire()
spaceicons:setClickCallback(UpdateSpacesIcon)

function GotoSpace(num)
    hs.eventtap.keyStroke({"ctrl"}, tostring(num), 0)
end

-- Keyboard shortcuts to move windows between screens
function MoveWindowToSpace(sp)
    local win = hs.window.focusedWindow()
    local uuid = win:screen():getUUID()
    local spaceID = hs.spaces.allSpaces()[uuid][sp]
    hs.spaces.moveWindowToSpace(win, spaceID)
    UpdateSpacesIconTimer:fire()
    hs.eventtap.keyStroke({"ctrl"}, sp)
end

local moveSpacesKey = {"ctrl", "shift"}
hs.hotkey.bind(moveSpacesKey, '1', function() MoveWindowToSpace(1) end, function() GotoSpace(1) end)
hs.hotkey.bind(moveSpacesKey, '2', function() MoveWindowToSpace(2) end, function() GotoSpace(2) end)
hs.hotkey.bind(moveSpacesKey, '3', function() MoveWindowToSpace(3) end, function() GotoSpace(3) end)
hs.hotkey.bind(moveSpacesKey, '4', function() MoveWindowToSpace(4) end, function() GotoSpace(4) end)
hs.hotkey.bind(moveSpacesKey, '5', function() MoveWindowToSpace(5) end, function() GotoSpace(5) end)
hs.hotkey.bind(moveSpacesKey, '6', function() MoveWindowToSpace(6) end, function() GotoSpace(6) end)
hs.hotkey.bind(moveSpacesKey, '7', function() MoveWindowToSpace(7) end, function() GotoSpace(7) end)
hs.hotkey.bind(moveSpacesKey, '8', function() MoveWindowToSpace(8) end, function() GotoSpace(8) end)
hs.hotkey.bind(moveSpacesKey, '9', function() MoveWindowToSpace(9) end, function() GotoSpace(9) end)

-- Play/pause music players when headphones are connected/disconnected
spoon.SpoonInstall:andUse("HeadphoneAutoPause", {start=true})

local toggleGoogleMeetMic = require('google-meet-mic')
hs.hotkey.bind({"ctrl", "cmd"}, "M", toggleGoogleMeetMic)

hs.notify.new({title="Hammerspoon", informativeText="Configuration reloaded"}):send()

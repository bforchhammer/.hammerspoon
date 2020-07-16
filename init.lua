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
local spaces = require("hs._asm.undocumented.spaces")
local spaceicons = hs.menubar.new()

function UpdateSpacesIcon()
    if spaces.isAnimating() then return end

    local activeSpaces = spaces.query(spaces.masks.currentSpaces)
    local icons = ""
    for screenId, screenSpaces in pairs(spaces.layout()) do
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

-- Keyboard shortcuts to move windows between screens
function MoveWindowToSpace(sp)
    local win = hs.window.focusedWindow()      -- current window
    local uuid = win:screen():spacesUUID()     -- uuid for current screen
    local spaceID = spaces.layout()[uuid][sp]  -- internal index for sp
    spaces.moveWindowToSpace(win:id(), spaceID) -- move window to new space
    spaces.changeToSpace(spaceID)              -- follow window to new space
    UpdateSpacesIconTimer:fire()
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

-- Play/pause music players when headphones are connected/disconnected
spoon.SpoonInstall:andUse("HeadphoneAutoPause", {start=true})

-- Simple utility to keep system alive
local caffeine = hs.menubar.new()
function setCaffeineDisplay(state)
    if state then
        caffeine:setTitle("☕")
    else
        caffeine:setTitle("😴")
    end
end

function caffeineClicked()
    setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
end
if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
end

-- Shortcut to open kitty
hs.application.enableSpotlightForNameSearches(true)
hs.hotkey.bind({"cmd"}, "return", function()
    local app = hs.application.get("kitty")
    if app then
        if not app:mainWindow() then
            app:selectMenuItem({"kitty", "New OS window"})
        elseif app:isFrontmost() then
            app:hide()
        else
	    app:activate()
        end
    else
	hs.application.launchOrFocus("kitty")
    end
end)

hs.notify.new({title="Hammerspoon", informativeText="Configuration reloaded"}):send()

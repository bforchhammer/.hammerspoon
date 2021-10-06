local function toggleGoogleMeetMic()
    local success, result, descriptor = hs.osascript.applescript('tell application "Google Chrome" to execute active tab of front window javascript "true"')
    print(success)
  
    if (success == false) then
      hs.dialog.blockAlert('Chrome Error', descriptor["NSLocalizedFailureReason"])
      return
    end
  
    local _, background = hs.osascript.applescript('tell application "Google Chrome" to execute active tab of front window javascript "window.getComputedStyle(document.querySelector(\'button[aria-label*=\\"⌘ + d\\"]\')).backgroundColor"')
  
    print(background)
  
    if (background == "rgb(234, 67, 53)") then
      hs.alert.show('🎙 Microphone ON 🟢')
    elseif (background == "rgb(60, 64, 67)") then
      hs.alert.show('🎙 Microphone OFF 🚫')
    else
      hs.alert.show('🎙⚠️ Something went wrong (No meeting in active tab?)')
      return
    end
  
    hs.osascript.applescript('tell application "Google Chrome" to execute active tab of front window javascript "document.querySelector(\'button[aria-label*=\\"⌘ + d\\"]\').click()"')
  end
  
  return toggleGoogleMeetMic
  
local widget = require("widget")
local textField1, textField2
local okButton, guideText
local cx, cy

local function textField1Listener(event)
    local len = string.len(event.target.text)
    guideText.text = "Club ID"
    if(len>8)then
        event.target.text = event.oldText
    end
end
local function textField2Listener(event)
    local len = string.len(event.target.text)
    guideText.text = "Passcode"
    if(len>4)then
        event.target.text = event.oldText
    end    
end

display.setDefault("background", 0.4, 0.6, 0.5)
cx = display.contentCenterX
cy = display.contentCenterY

guideText = display.newText("PANAMA* CLUB", cx, 50, "Arial", 20)

textField1 = native.newTextField(cx, cy - 140, 120 , 35)
textField1.align = "center"
textField1:addEventListener("userInput", textField1Listener)

textField2 = native.newTextField(cx, cy - 100, 120 , 35)
textField2.align = "center"
textField2.inputType = "number"
textField2.isSecure = true
textField2:addEventListener("userInput", textField2Listener)

okButton = widget.newButton(
    {
        x = cx, y = 240, width = 128,
        height = 128, defaultFile = "ok.png"
    }
)
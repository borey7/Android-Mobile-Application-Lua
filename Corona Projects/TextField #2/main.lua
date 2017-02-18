local widget = require("widget")
local textField1, textField2
local cx, cy

local function textField1Listener(event)
    local len = string.len(event.target.text)
    if(len>8)then
        event.target.text = event.oldText
    end
end
local function textField2Listener(event)
    local len = string.len(event.target.text)
    if(len>4)then
        event.target.text = event.oldText
    end    
end

display.setDefault("background", 0.5, 0.5, 0.5)
cx = display.contentCenterX
cy = display.contentCenterY

textField1 = native.newTextField(cx, cy - 40, 180 , 30)
textField1.align = "center"
textField1:addEventListener("userInput", textField1Listener)

textField2 = native.newTextField(cx, cy, 180 , 30)
textField2.align = "center"
textField2.inputType = "number"
textField2:addEventListener("userInput", textField2Listener)
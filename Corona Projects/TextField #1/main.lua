local widget = require("widget")
local textField1, textField2,result
local cx, cy

local function textField1Listener(event)
    if(event.phase =="ended") then
        print("textField #1 : " .. event.target.text)        
    end
end
local function textField2Listener(event)
    if(event.phase =="ended") then
        print("textField #2 : " .. event.target.text)
    end
end

local function resultListener(event)
    if(event.phase =="ended") then
        print(tonumber(textField1.text) + tonumber(textField2.text))
        result.text = tonumber(textField1.text) + tonumber(textField2.text)
    end
end

display.setDefault("background", 0.5, 0.5, 0.5)
cx = display.contentCenterX
cy = display.contentCenterY

textField1 = native.newTextField(cx, cy - 40, 180 , 30)
textField1:addEventListener("userInput", textField1Listener)

textField2 = native.newTextField(cx, cy, 180 , 30)
textField2:addEventListener("userInput", textField2Listener)

result = native.newTextField(cx, cy + 40, 180 , 30)
result:addEventListener("userInput", resultListener)
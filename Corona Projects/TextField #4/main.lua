local widget = require("widget")
local backgroundImage, logoImage
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

local function okButtonEventHandler(event)
    local id, passcode
    if(event.phase == "ended") then
        id = textField1.text
        passcode = textField2.text
        if(string.len(id)==string.len(passcode))then
            guideText.isVisible = false
            textField1.isVisible = false
            textField2.isVisible = false
            okButton.isVisible = false
            transition.to(logoImage, {time = 600, y = display.contentCenterY*2})
            backgroundImage.alpha = 1
        else
            guideText.text = "Invalid Login"
        end
    end
end

local function rotateButton(event)
    angle = angle +25
    if(angle > 360)then
        angle = 0
    end
    okButton.rotation = angle
    okButton.transition()
end

angle = 1
cx = display.contentCenterX
cy = display.contentCenterY

backgroundImage = display.newImage("background.png", cx, cy)
backgroundImage.alpha = 0.6

logoImage = display.newImage("panama.png", cx, 50)

guideText = display.newText("PANAMA* CLUB", cx, 100, "Arial", 20)

textField1 = native.newTextField(cx, cy - 100, 120 , 35)
textField1.align = "center"
textField1:addEventListener("userInput", textField1Listener)

textField2 = native.newTextField(cx, cy - 60, 120 , 35)
textField2.align = "center"
textField2.inputType = "number"
textField2.isSecure = true
textField2:addEventListener("userInput", textField2Listener)

okButton = display.newImage("ok.png",cx, 270)
okButton:addEventListener("touch",okButtonEventHandler)
timer.performWithDelay(100, rotateButton, 0)
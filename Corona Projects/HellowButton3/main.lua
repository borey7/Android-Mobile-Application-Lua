local widget = require("widget")
local myImage1, myImage2
local cx, cy

local function imageEventHander(event)
    if(event.phase == "ended") then --"ended" mean touch and then take cusor out of button
        if(myImage1.isVisible) then
            myImage1.isVisible = false
            myImage2.isVisible = true
        else
            myImage1.isVisible = true
            myImage2.isVisible = false
        end
    end
end

display.setDefault("background",1,1,1)
cx = display.contentCenterX
cy = display.contentCenterY
myImage1 = display.newImage("button-pause.png")
myImage2 = display.newImage("button-play.png")
myImage1.x = cx
myImage1.y = cy
myImage2.x = cx
myImage2.y = cy
myImage1:addEventListener("touch", imageEventHander)
myImage2:addEventListener("touch", imageEventHander)
myImage1.isVisible = false
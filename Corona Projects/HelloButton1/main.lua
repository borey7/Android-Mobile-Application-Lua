local widget = require("widget")
local myButton

local function handleButtonEvent(event)
    if(event.phase == "began") then
        print("Pressed")
    else
        print("Release")
    end
end

myButton = widget.newButton(
    {
        width = 200,
        height =40,
        label = "Submit",
        shape = "roundedRect",
        labelColor = {default={1,1,1}, over={1,1,1}}, --default is RGB
        fillColor = {default={0,0,0,0.5}, over={1,1,1,0.7}}, --0.5 is Grama that tell about how hard is it 
        strokeColor = {default={0,0,0,0.7}, over={1,1,1,0.5}}, --border color
        strokeWidth = 3,
        onEvent = handleButtonEvent
    }
)
display.setDefault("background",1,1,1)
myButton.x = display.contentCenterX
myButton.y = display.contentCenterY
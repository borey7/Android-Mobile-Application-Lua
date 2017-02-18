local widget = require("widget")
local myButton

myButton = widget.newButton(
    {
        width = 128,
        height = 128,
        onEevent = handleButtonEvent,
        defaultFile = "button-red.png",
        overFile = "button-green.png"
    }
)
display.setDefault("background",1,1,1)
myButton.x = display.contentCenterX
myButton.y = display.contentCenterY
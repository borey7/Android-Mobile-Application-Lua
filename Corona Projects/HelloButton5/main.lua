local widget = require("widget")
local sound_a, sound_b, sound_c
local myImage


local function handleButtonEvent(event)
    
end

local Button = widget.newButton(
    {
        left = 60,
        top = 210,
        width = 60,
        height =40,
        id = "button_a",
        label = "A",
        onEvent = handleButtonEvent,
        shape = "Rect",
        labelColor = {default={1,1,1}, over={0,0,0,0.5}},        
        fillColor = {default={0.4,0.4,0.4}, over={0.8,0.8,0.8}}            
    }
)
local Button = widget.newButton(
    {
        left = 130,
        top = 210,
        width = 60,
        height =40,
        id = "button_b",
        label = "B",
        onEvent = handleButtonEvent,
        shape = "Rect",
        labelColor = {default={1,1,1}, over={0,0,0,0.5}},        
        fillColor = {default={0.4,0.4,0.4}, over={0.8,0.8,0.8}}            
    }
)
local Button = widget.newButton(
    {
        left = 200,
        top = 210,
        width = 60,
        height =40,
        id = "button_c",
        label = "C",
        onEvent = handleButtonEvent,
        shape = "Rect",
        labelColor = {default={1,1,1}, over={0,0,0,0.5}},        
        fillColor = {default={0.4,0.4,0.4}, over={0.8,0.8,0.8}}            
    }
)
display.setDefault("background",1,1,1)
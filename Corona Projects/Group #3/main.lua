local widget = require("widget")
local rect1, rect2, img1, img2
local group1, group2, activegroup
local cx, cy

cx = display.contentCenterX
cy = display.contentCenterY

img1 = display.newImage("IMG/wrong.png", cx, 180)
img2 = display.newImage("IMG/right.png", cx, 180)

group1 = display.newGroup()
group2 = display.newGroup()
group1:insert(img1)
group2:insert(img2)

group1.isVisible = false
group2.isVisible = false
--[[
rect1 = display.newRect(cx, 50, 100, 100)
rect1:setFillColor(1, 0, 0)
rect2 = display.newRect(cx, 320, 100, 100)
rect2:setFillColor(0, 1, 0)
]]
local function hideToast()
	activegroup.isVisible = false
end

local  function showToast()
	activegroup.isVisible = true
end

local function toast(obj)
	activegroup = obj
	showToast()
	timer.performWithDelay(500, hideToast, 1);
end

local function buttonEvent(event)
	if(event.phase == "ended") then
		if(event.target.id == "buttton1") then
			toast(group1)
		else 
			toast(group2)	
		end
	end
end

local buttton1 = widget.newButton(
	{
		width = 100,
		height = 40,
		id = "buttton1",
		onEvent = buttonEvent,
		shape = "roundedRect",
		cornerRadius = 5,
		labelColor = {default = {1, 1, 1}, over = {1,1,1}},
		fillColor = {default = {0, 0, 0.5}, over = {0, 0, 0.7}},
	}
)
local buttton2 = widget.newButton(
	{
		width = 100,
		height = 40,
		id = "buttton2",
		onEvent = buttonEvent,
		shape = "roundedRect",
		cornerRadius = 5,
		labelColor = {default = {1, 1, 1}, over = {1,1,1}},
		fillColor = {default = {0, 0, 0.5}, over = {0, 0, 0.7}},
	}
)

display.setDefault("background", 1, 1, 1)
buttton1.x = cx
buttton1.y = 300
buttton1:setLabel("Wrong")

buttton2.x = cx
buttton2.y = 350
buttton2:setLabel("Right")
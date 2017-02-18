--[[
sdfsd
]]

local widget = require("widget")
local rect1, rect2, img1, img2
local group1, group2
local cx, cy

cx = display.contentCenterX
cy = display.contentCenterY

rect1 = display.newRect(cx, 50, 100, 100)
rect1:setFillColor(1, 0, 0)

rect2 = display.newRect(cx, 320, 100, 100)
rect2:setFillColor(0, 1, 0)

img1 = display.newImage("IMG/wrong.png", cx, 180)
img2 = display.newImage("IMG/right.png", cx, 440)

group1 = display.newGroup()
group1:insert(rect1)
group1:insert(img1)
group1.isVisible = true

group2 = display.newGroup()
group2:insert(rect2)
group2:insert(img2)
group2.isVisible = false

local function swapDisplay()
	group1.isVisible = not group1.isVisible
	group2.isVisible = not group2.isVisible
end

timer.performWithDelay(500, swapDisplay, 0) --0 is forever, 1 = once time, ...
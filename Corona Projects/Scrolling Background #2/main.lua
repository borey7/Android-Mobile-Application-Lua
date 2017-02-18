local screen_w, screen_h
local image_w, image_h
local speed

display.setStatusBar(display.HiddenStatusBar)

screen_w = 480
screen_h = 320
image_w = 850
image_h = 320
speed = 5

background1 = display.newImageRect("background1.png", image_w, image_h)
background1.x = screen_w/2
background1.y = screen_h/2

background2 = display.newImageRect("background2.png", image_w, image_h)
background2.x = 1090
background2.y = screen_h/2

local function scrollBackground(event)
	background1.x = background1.x - speed
	background2.x = background2.x - speed
	if(background1.x) < -610 then
		background1.x = 1090
	end 
	if(background2.x) < -610 then
		background2.x = 1090
	end
end

Runtime:addEventListener("enterFrame", scrollBackground);

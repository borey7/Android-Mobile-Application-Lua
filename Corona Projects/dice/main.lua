local widget = require("widget")
local d1, d2, d3, sum
local  imageBG, imageD1, imageD2, imageD3, imageHLT
local soundShake
local cx, cy
----------------------------------------------------

cx = display.contentCenterX
cy = display.contentCenterY
x1 = cx ;y1 = cy-75
x2 = cx-75 ;y2 = cy+50
x3 = cx+75 ;y3 = cy+50

imageBG = display.newImage("red.png", cx, cy)
----------------------------------------------------

local function  removeImage(obj)
	if(obj) then
		obj:removeSelf()
		obj = nil
	end
end

local function randomDice()
	d1 = math.random(1, 6)
	d2 = math.random(1, 6)
	d3 = math.random(1, 6)

	sum = d1 + d2 + d3

	removeImage(imageD1)
	removeImage(imageD1)
	removeImage(imageD1)
	removeImage(imageHLT)

	if(d1 == d2 and d2 == d3) then
		imageHLT = display.newImage("triple.png",cx , cy-175)
	elseif(sum >= 11) then
		imageHLT = display.newImage("hi.png",cx , cy-175)
	else
		imageHLT = display.newImage("lo.png",cx , cy-175)
	end
	
	imageD1 = display.newImage(d1..".png", x1, y1)
	imageD2 = display.newImage(d2..".png", x2, y2)
	imageD3 = display.newImage(d3..".png", x3, y3)
end

soundShake = audio.loadSound("dice.mp3")
local function buttonEvent(event)
	if(event.phase == "ended") then
		audio.play(soundShake, {loop = 0})
		randomDice()		
	end
end

function moveDice(obj)
	if(obj.x = x1) then
		transition.to(obj, {time = 300, x = x2})
	elseif(obj.x = x2)
end

imageHLT = display.newImage("triple.png",cx , cy-175)

buttonShake = widget.newButton(
	{
		x = cx,
		y = cy*2 - 75,
		width = 128,
		hight = 128,
		defaultFile = "play.png",
		onEvent = buttonEvent	
	}
)

randomDice()
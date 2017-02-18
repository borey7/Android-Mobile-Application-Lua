local physics = require("physics")

local weigth = display.contentWidth
local height = display.contentHeight

display.newImage("angrybird/background.png", weigth/2, height/2)

local txtScore = display.newText("Score", weigth - 30, height-30)

local function countTouchListener()

end

local function ballEnterFrame( self )
	local x = self.x
	local y = self.y
	print("ballEnterFrame-----------------------")
	if(x == nil or y == nil) then
		return
	end
	if( x < -29 or x > weigth or y < -50 or y > height) then
		print("Remove (out of screen).."..tostring(self))
		Runtime:removeEventListener("enterFrame", self)
		self:removeSelf()
	end
end

score = 0

local function handleBallTouch( event )
	if(event.phase == "began") then
		if(event.target.id == "angry") then
			audio.play(sndHit)
			score = score + 1
		else
			audio.play(sndFailed)
			score = 0
		end
		txtScore.text = string.format("%05d", score)
		countTouchListener(event)	
		event.target:removeSelf()
		--event.target = nil		
	end
end

local function loadBall()
    local x = math.random(30, 450)
    --local radius = math.random(10, 50)
    -- local r = math.random(0, 255)/255
    -- local g = math.random(0, 255)/255
    -- local b = math.random(0, 255)/255
    local ball

    local t = math.random(1,2)
    local b = math.random(1,10)
    local y, v, bird
    if(t==1)then
    	y = -50
    	v = 1
    else
    	y = 350
    	v = -1
    end
    
    bird = display.newImage("angrybird/"..b..".png",x,y)
    if(b>= 8) then
    	bird.id = "pokemon"
    else
    	bird.id = "angry"
    end
    --ball = display.newCircle(x, -250, radius)
    --ball:setFillColor(r, g, b)
    bird:addEventListener("touch", handleBallTouch)
    bird:addEventListener("enterFrame", ballEnterFrame)
    Runtime:addEventListener( "enterFrame", bird)
    print("create..."..tostring(bird))

    physics.setGravity(0, 2)
    physics.addBody(bird, "dynamic")
end

physics.start()
timer.performWithDelay(300, loadBall, 0)
























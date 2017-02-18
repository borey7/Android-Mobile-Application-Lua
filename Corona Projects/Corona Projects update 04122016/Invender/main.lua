local physics = require("physics")
local cw, ch, cx, cy
local txtInvader, txtBased, txtBullet
local sInvader, sBased, sBullet
local invader

local function updateGame( event )
	invader.x = invader.x + 5
	if(invader.x > cw + 50) then
		invader.x = - 50
	end
	txtInvader.text = string.format("%03d", sInvader)
	txtBullet.text = string.format("%03d", sBullet)
	txtBased.text = string.format("%03d", sBased)
end

local  function createInvader()
	invader = display.newImage("invader.png")
	invader.x = -50
	invader.y = 80
	invader.name = 'invader'
	physics.addBody(invader, "static", {density = 1, friction = 0, bounce = 0});
end

local function shoot( event )
	local buttlet
	if(event.phase == "began") then
		sBullet = sBullet - 1
		bullet = display.newText(string.char(math.random(65,90)), based.x, based.y - 50, "Arial", 30)
		--bullet = display.newRect(based.x, based.y - 50, 10, 30)
		bullet:setFillColor(
			math.random(255)/255,
			math.random(255)/255,
			math.random(255)/255)
		bullet.name = "bullet"
		physics.addBody(bullet, "dynamic")
		bullet.gravityScale =  1
		bullet:setLinearVelocity(0, -600)
	end
end

local function onCollision( event )
	local obj1 = event.object1.name
	local obj2 = event.object2.name
	if(event.phase == "ended") then
		print(obj1, obj2)
		if(obj1 == "invader" and obj2 == "bullet") then
			sInvader = sInvader + 1
		end
		if(obj1 == "based" and obj2 == "bullet") then
			sBased = sBased - 1
		end
	end
end

display.setStatusBar(display.HiddenStatusBar)
physics.start()

cw, ch = display.contentWidth, display.contentHeight
cx, cy = display.contentCenterX, display.contentCenterY

background = display.newRect(cx, cy, cw, ch)
background:setFillColor(0, 1, 1)

ground = display.newRect(cx, ch - 25, cw, 50)
ground:setFillColor(0, 0.8, 0)

based = display.newRect(cx, ch - 60, 40, 40)
based:setFillColor(1, 0, 0)
based.gravityScale = 0
based.name = "based"
physics.addBody(based, "static")

txtInvader = display.newText("000", 50, ch - 100, "Arial", 30)
txtBased = display.newText("000", 50, ch - 130, "Arial", 30)
txtBullet = display.newText("000", 50, ch - 160, "Arial", 30)

Runtime:addEventListener("touch", shoot)
Runtime:addEventListener("enterFrame", updateGame)
Runtime:addEventListener("collision", onCollision)

-- Called when a key event has been received
local function onKeyEvent( event )
	print(event.nativeKeyCode)
    local message = "Key '" .. event.keyName .. "' has key code: " .. tostring( event.nativeKeyCode )
    print(message)
    return false
end

-- Add the key event listener
Runtime:addEventListener( "key", onKeyEvent )

sInvader = 0
sBased = 100
sBullet = 100

createInvader()
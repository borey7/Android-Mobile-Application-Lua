local widget = require("widget")
local physics = require("physics")
local cx, cy, score, power
local txtScore, txtPower
local sndHit, sndFailed, sndBackground
local txtGroup, birdGroup
local birdSheet = {}
local birdSprite={}
birdSheetN = 1
local sheetData, spriteData

w, h = display.contentWidth, display.contentHeight
cw, ch = display.contentWidth, display.contentHeight
cx, cy = display.contentCenterX, display.contentCenterY

local floor
local floorl
local basedFloor

local function countTouchListener(event)
    if (event.phase == "began") then
        power = power - 1
        txtPower.text = string.format("%3d", power)
    end
end

local function handleBirdTouch(event)
    -- if (event.phase == "began") then
    --     if (event.target.id == "angry") then
    --         audio.play(sndHit)
    --         score = score + 1
    --     else
    --         audio.play(sndFailed)
    --         score = 0
    --     end
    --     txtScore.text = string.format("%05d", score)
    --     countTouchListener(event)
    --     event.target:removeSelf()
    -- end
end

local birdAge = {}

local function birdEnterFrame(self)
	--#######################
	--remove chick	
	if(birdSprite[birdSheetN-1]) then
		if(birdSprite[birdSheetN-1].y < -20 ) then
			--birdSheet[birdSheetN-1]:removeSelf()
			birdSprite[birdSheetN-1]:removeSelf()
			--birdSheet[birdSheetN-1] = nil
			birdSprite[birdSheetN-1] = nil
		else
			--birdSheet[birdSheetN-1].y = birdSheet[birdSheetN-1].y - 1
			birdSprite[birdSheetN-1].y = birdSprite[birdSheetN-1].y - 1
		end
	elseif(birdSprite[10]) then
		if(birdSprite[10].y < -20 ) then
			--birdSheet[10]:removeSelf()
			birdSprite[10]:removeSelf()
			--birdSheet[10] = nil
			birdSprite[10] = nil
		else
			--birdSheet[10].y = birdSheet[10].y - 1
			birdSprite[10].y = birdSprite[10].y - 1
		end
	end
	--#######################
    local x = self.x
    local y = self.y
    if (x == nil or x == nil) then
        return
    end        
    if(self.id == "egg") then   
    	if( birdAge[self.count]) then 
    		birdAge[self.count] = birdAge[self.count] + 1    		
    		--print("bird ... "..self.count.." age : "..birdAge[self.count])
    	else birdAge[self.count] = 0 end
    	---############################
    	---Hatch
    	---############################
		if(birdAge[self.count] > 500) then 
			score = score + 1
			txtScore.text = string.format("%05d", score)
			eggX = self.x
			eggY = self.y
			print("bird..."..self.count.."... "..birdAge[self.count].." > 500") 
			print("Remove...bird..."..self.count)
	        Runtime:removeEventListener("enterFrame", self)
	        birdGroup:remove(self)  
	        self:removeSelf()
	        ---############################
    		---chick    	    		
    		birdSheet[birdSheetN] = graphics.newImageSheet("bird.png", sheetData )
			birdSprite[birdSheetN] = display.newSprite(birdSheet[birdSheetN] , spriteData)
			birdSprite[birdSheetN]:scale(0.3,0.3)
			birdSprite[birdSheetN].x = eggX
			birdSprite[birdSheetN].y = eggY
			birdSprite[birdSheetN]:play()			
			birdSheetN = birdSheetN%10 + 1
    		---############################

		end
	    if(x < -20 or x > w+50 or y < -50 or y > h + 50) then
	        print("Remove...bird..."..self.count)
	        Runtime:removeEventListener("enterFrame", self)
	        birdGroup:remove(self)  
	        self:removeSelf()
		end
	else		
		if(x < -20 or x > w+50 or y < -50 or y > h - 100) then
	        --print("Remove...")
	        Runtime:removeEventListener("enterFrame", self)
	        birdGroup:remove(self)  
	        self:removeSelf()
	   end
	end
   ---- 
   self.y = self.y + 1

end

local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
        -- if (event.target.id == "angry") then
        --     audio.play(sndHit)
        --     score = score + 1
        --     self:removeSelf()
        -- else
        --     audio.play(sndFailed)
        --     score = 0
        --     self:removeSelf()
        -- end
  --       if(self.id == "angry" and event.other.name == "bullet")then
  --       	audio.play(sndHit)
  --           score = score + 1
  --           self:removeSelf()
  --       elseif(self.id == "pokemon" and event.other.name == "bullet") then
  --       	audio.play(sndFailed)
  --           score = 0
  --           self:removeSelf()
		-- end

    elseif ( event.phase == "ended" ) then
        --print( self.myName .. ": collision ended with " .. event.other.myName )
    end
end
N = 0
local function loadBird()
    local b = math.random(1, 10)    
    local y, v, bird    
    y = -50
    v = 1    
    floorX = 50
    floorlX = floorX + 45
    if(math.random(2) == 1) then
    	x = 50
    else
    	x = w - 50
    	floorX = w - 50
    	floorlX = floorX - 45
    end        
    --bird = display.newImage("angrybird/"..b .. ".png", x, y)
    bird = display.newImage("angrybird/egg2.png", x, y)
    --bird:scale(0.2, 0.2)
    -- if (b >= 8) then
    --     bird.id = "pokemon"
    -- else
    --     bird.id = "angry"
    -- end
    N = N + 1
    bird.id = "egg"
    bird.age = 0
    bird.count = N

	bird.collision = onLocalCollision
	bird:addEventListener( "collision" )
    birdGroup:insert(bird)
    bird:addEventListener("touch", handleBirdTouch)
	bird.enterFrame = birdEnterFrame
	Runtime:addEventListener("enterFrame", bird)     	
    physics.addBody(bird, "dynamic")
    bird.count = N
    print("Create...bird..."..bird.count)
    physics.setGravity(0, 9.8*v)
    floor = display.newRect(floorX, 0, 100, 20)
    floor.name = "floor"
	floor.enterFrame = birdEnterFrame
	Runtime:addEventListener("enterFrame", floor)     
    physics.addBody(floor, "static")
    --########
    floorl = display.newRect(floorlX, 20, 10, 80)
    floorl.name = "floor"
	floorl.enterFrame = birdEnterFrame
	Runtime:addEventListener("enterFrame", floorl)     
    physics.addBody(floorl, "static")
    --print("Create...")
    
    ---move baseFloor
   --  if(basedFloor.x > w + 20) then
  	-- 	basedFloor.x = cx
  	-- end
  	-- basedFloor.x = basedFloor.x+30


end

score = 0
power = 100

-- cx = display.contentCenterX
-- cy = display.contentCenterY
--display.newImage("angrybird/background.png", cx, cy)
display.setDefault("background", 0.3, 0.4, 0.5)

txtGroup = display.newGroup()
birdGroup = display.newGroup()

txtScore = display.newText("00000", 10, 300, "Arial", 20)
txtScore:setFillColor(1, 1, 1)
txtScore.anchorX = 0

txtPower = display.newText("100", 470, 300, "Arial", 20)
txtPower:setFillColor(1, 1, 1)
txtPower.anchorX = 1

txtGroup:insert(txtScore)
txtGroup:insert(txtPower)
txtGroup:toFront()

sndHit = audio.loadSound("angrybird/hit.mp3")
sndFailed = audio.loadSound("angrybird/failed.mp3")
sndBackground = audio.loadSound("angrybird/background.mp3")

physics.start()
loadBird()
tmrLoadBird = timer.performWithDelay(5000, loadBird, 0)
Runtime:addEventListener("touch", countTouchListener)

-- audio.play(sndBackground, 
--    {channel = 1, loops = -1, fadein = 5000}
-- )

---

local wallLeft = display.newRect(0, cy-60, 20, h-60)
wallLeft:setFillColor(0, 1, 0)
wallLeft.gravityScale = 10
wallLeft.name = "wallLeft"
physics.addBody(wallLeft, "static")
local wallRight = display.newRect(w, cy-60, 20, h-60)
wallRight:setFillColor(0, 1, 0)
wallRight.gravityScale = 10
wallRight.name = "wallRight"
physics.addBody(wallRight, "static")

local buttomLelf = display.newRect(cx-100, h+20, 200, 20)
buttomLelf:setFillColor(0, 1, 0)
buttomLelf.gravityScale = 0
buttomLelf.name = "buttom"
buttomLelf.rotation = -15
physics.addBody(buttomLelf, "static")

local buttomRight = display.newRect(cx+100, h+20, 200, 20)
buttomRight:setFillColor(0, 1, 0)
buttomRight.gravityScale = 0
buttomRight.name = "buttom"
buttomRight.rotation = 15
physics.addBody(buttomRight, "static")

-- basedFloor = display.newRect(cx, h, 20, 60)
-- basedFloor:setFillColor(0, 1, 0)
-- basedFloor.gravityScale = 0
-- basedFloor.name = "basedFloor"
-- physics.addBody(basedFloor, "static")

local based = display.newRect(cx, h-10, 40, 40)
based:setFillColor(1, 0, 0)
based.gravityScale = 0
based.name = "based"
physics.addBody(based, "static")

local function shoot( event )
	local buttlet
	if(event.phase == "began") then
		--sBullet = sBullet - 1
		--bullet = display.newImage("angrybird/Leaf.png", based.x, based.y - 50)
		--bullet = display.newText(string.char(math.random(65,90)), based.x, based.y - 50, "Arial", 30)
		bullet = display.newCircle(based.x, based.y - 50, 10, 30)
		bullet:setFillColor(
			math.random(255)/255,
			math.random(255)/255,
			math.random(255)/255)		
		bullet.name = "bullet"
		physics.addBody(bullet, "dynamic")		
		bullet.gravityScale =  -2
		vx, vy = cx*10-event.x*10, -600
		bullet:setLinearVelocity(vx, vy)
	end
end

Runtime:addEventListener("touch", shoot)


---################################################
---################################################
---################################################

sheetData = {
    frames = {
        {x = 0, y = 0, width = 182, height = 168 },
        {x = 182, y = 0, width = 182, height = 168 },
        {x = 364, y = 0, width = 182, height = 168 },
        {x = 546, y = 0, width = 182, height = 168 },
        {x = 727, y = 0, width = 182, height = 168 },
        {x = 0, y = 160, width = 182, height = 168 },
        {x = 182, y = 160, width = 182, height = 168 },
        {x = 364, y = 160, width = 182, height = 168 },
        {x = 546, y = 160, width = 182, height = 168 },
        {x = 727, y = 160, width = 182, height = 168 },
        {x = 0, y = 342, width = 182, height = 168 },
        {x = 182, y = 342, width = 182, height = 168 },
        {x = 364, y = 342, width = 182, height = 168 },
        {x = 546, y = 342, width = 182, height = 168 },
        {x = 727, y = 342, width = 182, height = 168 }
    }
}

spriteData = {
    name = "bird",
    start = 1,
    count = 14,
    time = 700,
    loopCount = 0,
    loopDirection = "forward"
}

function touchImage(event)
    if(event.phase == "moved") then
        birdSprite.x = event.x         
        birdSprite.y = event.y
    end
end

-- birdSheet = graphics.newImageSheet("bird.png", sheetData )
-- birdSprite = display.newSprite(birdSheet , spriteData)
-- birdSprite:scale(0.3,0.3)
-- birdSprite.x = display.contentCenterX
-- birdSprite.y = display.contentCenterY
-- birdSprite:play()
--birdSprite:addEventListener("touch", touchImage)
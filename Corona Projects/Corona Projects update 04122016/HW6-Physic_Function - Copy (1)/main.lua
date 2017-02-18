local widget = require("widget")
local physics = require("physics")
local cx, cy, score, power
local txtScore, txtPower
local sndHit, sndFailed, sndBackground
local txtGroup, birdGroup
local birdSheet = {}
local birdSprite={}
local ageMeter = {}
local ageMeterText = {}
birdSheetN = 1
local sheetData, spriteData

w, h = display.contentWidth, display.contentHeight
cw, ch = display.contentWidth, display.contentHeight
cx, cy = display.contentCenterX, display.contentCenterY

sBullet = 1000
local bulletCount = display.newText("1000", cx, 20, "Arial", 20)

local floor
local floor2 = {}
local floorl
local basedFloor

local bg = display.newImage("bg.png", cx, cy)
bg:toBack()
local function countTouchListener(event)
    if (event.phase == "began") then
        power = power - 1
        txtPower.text = string.format("%3d", power)
    end
end

local function handleBirdTouch(event)
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
    		if(birdAge[self.count] > 300 and self.y < 20) then self.y = 20 end    		
    		birdAge[self.count] = birdAge[self.count] + 1    		
    		--print("bird ... "..self.count.." age : "..birdAge[self.count])
    		r, g, b = 255-birdAge[self.count],555-birdAge[self.count], 355-birdAge[self.count]
    		ageMeterText[self.count]:setFillColor(r, g, b)    		
    	else birdAge[self.count] = 0 end
    	---############################
    	---Hatch
    	---############################    
		if(birdAge[self.count] > 500 ) then 
			audio.play(sndHit)
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
			ageMeterText[self.count]:removeSelf()
    		ageMeterText[self.count] = nil

			birdSheetN = birdSheetN%10 + 1

    		---############################


		end
	    --if(x < -20 or x > w+50 or y < -150 or y > h + 50) then
	   	if(x < -20 or x > w+50 or y > h + 50) then
	    	audio.play(sndFailed)
	        print("Remove...bird..."..self.count)
	        Runtime:removeEventListener("enterFrame", self)
	        birdGroup:remove(self)  
	        self:removeSelf()
		end
	else		
		if(x < -20 or x > w+50 or y < -50 or y > h-100 ) then
	        --print("Remove...")
	        Runtime:removeEventListener("enterFrame", self)
	        birdGroup:remove(self)  
	        self:removeSelf()	        
	   end
	end
   ---- 
   self.y = self.y + 1
   if(floor2[self.count]) then 
   		floor2[self.count].y = self.y + 28
   		if(floor2[self.count].y > h - 100) then
	       	floor2[self.count]:removeSelf()
	       	floor2[self.count] = nil	    	
   		end
   	end
   if(ageMeterText[self.count]) then
   		ageMeterText[self.count].x = self.x
   		ageMeterText[self.count].y = self.y-30
   		ageMeterText[self.count].text = tostring(birdAge[self.count])
   end   

end

local function onLocalCollision( self, event )
    if ( event.phase == "began" ) then
        -- if (event.target.id == "angry") then
        
  --       if(self.id == "angry" and event.other.name == "bullet")

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
    floorX = 70
    floorlX = floorX + 45
    if(math.random(2) == 1) then
    	x = 50
    else
    	x = w - 50
    	floorX = w - 70
    	floorlX = floorX - 45
    end
    --bird = display.newImage("angrybird/"..b .. ".png", x, y)
    N = N + 1

    ---Create nest
        --floor = display.newRect(floorX, 0, 100, 1)        
    if(floorX == w - 70) then
    	floor = display.newImage("nestR_2.png", floorX, -20)
    	floor2[N]= display.newImage("nestR.png", floorX, -20)    	
    	floor2[N]:toBack()
    else
    	floor = display.newImage("nestL_2.png", floorX, -20)
    	floor2[N] = display.newImage("nestL.png", floorX, -20)    
    	floor2[N]:toBack()
    end
	bg:toBack()
    floor.name = "floor"
	floor.enterFrame = birdEnterFrame
	Runtime:addEventListener("enterFrame", floor)     
    physics.addBody(floor, "static")
    --########
 --    floorl = display.newRect(floorlX, 20, 10, 80)
 --    floorl.name = "floor"
	-- floorl.enterFrame = birdEnterFrame
	-- Runtime:addEventListener("enterFrame", floorl)     
 --    physics.addBody(floorl, "static")    
    --create bird
    bird = display.newImage("angrybird/egg2.png", x, y)
    ageMeterText[N] = display.newText(tostring(N), x+40, y-40, "Arial", 20)
    ageMeterText[N]:setFillColor(255, 255, 255)
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

end

score = 0
power = 100

-- cx = display.contentCenterX
-- cy = display.contentCenterY
--display.newImage("angrybird/background.png", cx, cy)
display.setDefault("background", 0.3, 0.4, 0.5)

txtGroup = display.newGroup()
birdGroup = display.newGroup()

txtScore = display.newText("00000", cx-50, 50, "Arial", 40)
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

audio.play(sndBackground, 
   {channel = 1, loops = -1, fadein = 5000}
)

---

local wallLeft = display.newRect(0-9, cy-60, 20, h-60)
wallLeft:setFillColor(0, 1, 0)
wallLeft.gravityScale = 10
wallLeft.name = "wallLeft"
physics.addBody(wallLeft, "static")

local wallRight = display.newRect(w+9, cy-60, 20, h-60)
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

--local based = display.newRect(cx, h-10, 40, 40)
local based = display.newImage("based2.png", cx, h-10)
--based:setFillColor(1, 0, 0)
based.gravityScale = 0
based.name = "based"
physics.addBody(based, "static")

local function shoot( event )
	angleX = event.x
	if(angleX<cx) then agleX = angleX*10 end
	based:rotate(angleX)
	local buttlet
	if(event.phase == "began") then
		sBullet = sBullet - 1
		bulletCount.text = string.format("%04d", sBullet)
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
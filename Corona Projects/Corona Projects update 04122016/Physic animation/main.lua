local widget = require("widget")
local physics = require("physics")
local cx, cy, score, power
local txtScore, txtPower
local sndHit, sndFailed, sndBackground
local txtGroup, birdGroup

local function countTouchListener(event)
    if (event.phase == "began") then
        power = power - 1
        txtPower.text = string.format("%3d", power)
    end
end

local function handleBirdTouch(event)
    if (event.phase == "began") then
        if (event.target.id == "angry") then
            audio.play(sndHit)
            score = score + 1
        else
            audio.play(sndFailed)
            score = 0
        end
        txtScore.text = string.format("%05d", score)
        countTouchListener(event)
        event.target:removeSelf()
    end
end

local function birdEnterFrame(self)
    local x = self.x
    local y = self.y
    if (x == nil or x == nil) then
        return
    end
    if(x < -20 or x > 500 or y < -50 or y > 350) then
        print("Remove...")
        Runtime:removeEventListener("enterFrame", self)
        birdGroup:remove(self)  
        self:removeSelf()
   end
end

local function loadBird()
    local x = math.random(30, 450)
    local t = math.random(1, 2)
    local b = math.random(1, 10)
    local y, v, bird
    if (t == 1) then
    	y = -50
    	v = 1
    else
    	y = 350
    	v = -1
    end
    bird = display.newImage("angrybird/"..b .. ".png", x, y)
    if (b >= 8) then
        bird.id = "pokemon"
    else
        bird.id = "angry"
    end
    birdGroup:insert(bird)
    bird:addEventListener("touch", handleBirdTouch)
	bird.enterFrame = birdEnterFrame
    Runtime:addEventListener("enterFrame", bird) 
    physics.setGravity(0, 9.8 * v)
    physics.addBody(bird, "dynamic")
    print("Create...")
end

score = 0
power = 100

cx = display.contentCenterX
cy = display.contentCenterY
display.newImage("angrybird/background.png", cx, cy)

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
tmrLoadBird = timer.performWithDelay(300, loadBird, 0)
Runtime:addEventListener("touch", countTouchListener)

audio.play(sndBackground, 
   {channel = 1, loops = -1, fadein = 5000}
)
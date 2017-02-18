local manSheet, manSprite
local sheetData, spriteData
local cx, cy

local t = 100

sheetData = {
    width = 184,
    height = 325,
    numFrames = 8
}

spriteData = {
    name = "skate",
    start = 1,
    count = 8,
    time = t,
    loopCount = 0,
    loopDirection = "forward"
}

local function touchSprite(event)
    if(event.phase == "began") then
        if (manSprite.isPlaying) then
            event.target:pause()
        else
            event.target:play()
        end
    end
end

manSheet = graphics.newImageSheet("man.png", sheetData)
manSprite = display.newSprite(manSheet, spriteData)

display.setDefault("background", 128/255)
manSprite.x = display.contentCenterX
manSprite.y = display.contentCenterY
manSprite:addEventListener("touch", touchSprite)
manSprite:play()

cx = display.contentCenterX
cy = display.contentCenterY

local function leftListener(event)
    if(event.phase == "began") then
    if(manSprite) then
        manSprite:removeSelf()
        manSprite = nil
        t = t + 100   
        print(t)
        spriteData.time = t   
        manSprite = display.newSprite(manSheet, spriteData)        
        manSprite.x = display.contentCenterX
        manSprite.y = display.contentCenterY
        manSprite:addEventListener("touch", touchSprite)
        manSprite:play()
        end
    end      
end

local function rightListener(event)
    if(event.phase == "began") then
    if(manSprite) then
        manSprite:removeSelf()
        manSprite = nil
        t = t - 100   
        print(t)
        spriteData.time = t   
        manSprite = display.newSprite(manSheet, spriteData)        
        manSprite.x = display.contentCenterX
        manSprite.y = display.contentCenterY
        manSprite:addEventListener("touch", touchSprite)
        manSprite:play()
        end
    end   
end

local left = display.newRect( 0, 0, cx, cy * 5)
left:addEventListener( "touch", leftListener)

local right = display.newRect( cx * 2, 0, cx, cy * 5)
right:addEventListener( "touch", rightListener)
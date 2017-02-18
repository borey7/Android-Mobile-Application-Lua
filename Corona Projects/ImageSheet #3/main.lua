local boySheet, boySprite
local sheetData, spriteData

sheetData = {
    width = 200 ,
    height = 240 ,
    numFrames = 4
}

spriteData = {
    name  = "skate",
    start = 1,
    count = 4,
    time = 800,
    loopCount = 0,
    loopDirection = "forward"    
}

local function touchSprite(event)
    if(event.phase == "began") then
        if(boySprite.isPlaying) then
            event.target:pause()
        else
            event.target:play()
        end
    end
end

boySheet = graphics.newImageSheet("boy.png", sheetData)
boySprite = display.newSprite(boySheet, spriteData)

display.setDefault("background", 255, 255, 255)
boySprite.x = display.contentCenterX
boySprite.y = display.contentCenterY
boySprite:addEventListener("touch",touchSprite)
boySprite:play()
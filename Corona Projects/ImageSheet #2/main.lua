local birdSheet, birdSprite
local sheetData, spriteData

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

local function touchImage(event)
    if(event.phase == "moved") then
        birdSprite.x = event.x         
        birdSprite.y = event.y
    end
end

birdSheet = graphics.newImageSheet("bird.png", sheetData )
birdSprite = display.newSprite(birdSheet , spriteData)

birdSprite:addEventListener("touch", touchImage)

display.setDefault("background", 255)
birdSprite.x = display.contentCenterX
birdSprite.y = display.contentCenterY
birdSprite:play() 
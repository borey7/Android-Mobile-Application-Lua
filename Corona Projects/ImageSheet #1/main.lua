local imageSheet, imageSprite
local sheetData, spriteData

sheetData = {
    frames = {
        {x = 0, y = 0 , width = 300 , height = 300},
        {x = 300, y = 0 , width = 300 , height = 300},
        {x = 600, y = 0 , width = 300 , height = 300}
    }
}

spriteData = {
    name = "logo",
    start = 1,
    count = 3,
    time = 2000,
    loopCount = 0,
    loopDirection = "forward"
}

imageSheet = graphics.newImageSheet("logo.png", sheetData)
imageSprite = display.newSprite(imageSheet, spriteData)

display.setDefault("background", 255)
imageSprite.x = display.contentCenterX
imageSprite.y = display.contentCenterY
imageSprite:play()
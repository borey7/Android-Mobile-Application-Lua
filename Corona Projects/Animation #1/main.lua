local adsImage
local cx, cy, pos

local function changeAds(event)
    pos = pos + 1
    if(pos>8) then
        pos = 1
    end
    if(adsImage) then
        adsImage:removeSelf()
        adsImage = nil
        adsImage = display.newImage(pos .. ".png", cx, cy)
    end
end

display.setDefault("background",12/255, 11/255, 11/255)
cx = display.contentCenterX
cy = display.contentCenterY
pos = 1
adsImage = display.newImage(pos .. ".png", cx, cy)

timer.performWithDelay(1500, changeAds, 0)

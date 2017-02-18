local adsImage, prevImage
local cx, cy, pos

local function changeAds(event) 
    pos = pos+1
    if( pos > 8 ) then
        pos = 1
    end
    if(prevImage) then
        prevImage:removeSelf()
        prevImage = nil
    end
    if(adsImage) then
        prevImage = adsImage
        transition.to(adsImage, {time = 500, x=-120})
        adsImage = display.newImage(pos .. ".png", 400, cy)
        transition.to(adsImage, {time = 300, x = cx})
    end
end

display.setDefault("background",11/255,11/255,11/255)
cx = display.contentCenterX
cy = display.contentCenterY

pos = 1
adsImage = display.newImage(pos .. ".png",cx ,cy)
timer.performWithDelay(1500, changeAds, 0)
local adsFile, adsImage
local cx, cy, pos

local function changeAds(evet)
    transition.to(adsImage[pos], {time = 500, x = 440})
    pos = (pos % 8)+1
    transition.to(adsImage[pos], {time = 300, x = cx})
end

display.setDefault("background", 12/255, 11/255 , 11/255)
cx = display.contentCenterX
cy = display.contentCenterY

adsFile = {"1.png","2.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png"}
adsImage = {}

for i=1, #adsFile do
    table.insert(adsImage, display.newImage(adsFile[i], 440, cy))
end

pos = 1
transition.to(adsImage[pos], {time = 300, x = cx})
timer.performWithDelay(1500, changeAds, 0)
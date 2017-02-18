local widget = require("widget")
local cx, cy, cw, ch
local scrollView, contents, bodyText
local path, file
local imgLogo, imgBurger

cx = display.contentCenterX
cy = display.contentCenterY
cw = display.contentWidth
ch = display.contentHeight

path = system.pathForFile("contents.txt", system.ResourceDirectory)
file, err = io.open(path, "r")

if (file) then
    contents = file:read("*a")
    io.close(file)
    file = nil
else
    contents = "* ERROR *"
end

scrollView = widget.newScrollView(
    {
        top = 75,
        left = 0,
        width = cw,
        height = ch,
        topPadding = 20,
        bottomPadding = 20,
        hideBackground = true,
        horizontalScrollDisabled = true
    }    
)

display.setDefault("background", 1, 1, 1)

imgLogo = display.newImage("images/0.png", cx, 20)
imgBurger = display.newImage("images/1.png",cx,85)

bodyText = display.newText(contents,cx,190,cw-20,450, "Cloud-Light",20)
bodyText.anchorY = 0
bodyText:setTextColor(0,0,0)

scrollView:insert(imgBurger)
scrollView:insert(bodyText)
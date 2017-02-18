local widget = require("widget")
local cx, cy, cw, ch
local scrollView, headerText, bodyText, contents

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
        top = 60,
        left = 0,
        width = cw,
        height = ch,
        topPadding = 20,
        bottomPadding = 20,
        hideBackground = true,
        horizontalScrollDisabled = true
    }    
)

display.setDefault("background", 1, 0, 0)
headerText = display.newText("เกี่ยวกับรั้ว",cx ,40 ,"Cloud-Bold", 60)

bodyText = display.newText(contents,0,0,cw-20,500, "Cloud-Light",20)
bodyText.x = cx
bodyText.anchorY = 0
bodyText:setTextColor(1,1,1)
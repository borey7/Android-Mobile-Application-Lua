local widget = require("widget")
local scrollView, myText, contents
local path, file

path = system.pathForFile("contents.txt", system.ResourceDirectory)
file, err = io.open(path, "r")

if(file) then
    contents = file:read("*a")
    io.close(file)
    file = nil
else
    contents = "* ERROR *"
end

scrollView = widget.newScrollView(
    {
        top = 0,
        left = 0,
        width = display.contentWidth,
        height = display.contentHeight,
        topPadding  = 20,
        horizontalScrollDisabled = true,
        hideBackground = true
    }
)

display.setDefault("background",1,0,0)
myText = display.newText(contents, 0,0,display.contentWidth-20, 500, "Cloud-Light", 20)
myText.anchorY = 0
myText:setTextColor(1,1,1)
myText.x = display.contentCenterX

scrollView:insert(myText)

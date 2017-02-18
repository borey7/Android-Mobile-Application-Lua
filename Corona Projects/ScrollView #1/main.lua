local widget = require("widget")

local scrollView, myText, contents

scrollView = widget.newScrollView(
    {
        top = 20,
        left = 0,
        width = display.contentWidth,
        height = display.contentHight,
        topPadding = 20,
        bottomPadding = 20,
        horizontalScrollDisabled = true
    }
)

display.setDefault("background",1,1,1)
contents = "School of Computing Technology!"
contents = string.rep(contents, 10)

myText =  display.newText(contents, 0, 0, display.contentWidth - 20 , 800, "Cloud-Light", 20)
myText.anchorY = 0
myText:setTextColor(0,0,0)
myText.x = display.contentCeterX

scrollView:insert(myText)

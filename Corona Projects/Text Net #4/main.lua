local widget = require("widget")
local myText, myImage, myButton
local card, options
local cx, cy

local function loadTextListener(event)
    if(not event.isError) then
        myText.text = event.response
    end
end

local function loadImageListener(event)
    if(not event.isError)then
        if(cardImage)then
            cardImage:removeSelf()
            cardImage = nil
        end
        cardImage = display.newImage(
            event.response.filename,
            event.response.baseDirectory,
            cx, 130
        )    
    end
end

local function randomCard()
    card = math.random(1,78)
    network.download(
        "http://cs.pkru.ac.th/app/tarot"..card..".png",
        "GET",
        loadImageListener,
        {},
        card .. ".png",
        system.TemporaryDirectory
    )
    network.request(
        "http://cs.pkru.ac.th/app/tarot/"..card..".txt",
        "GET",
        loadTextListener
    )
end

local function handleButtonEvent(event)
    if(event.phase=="ended")then
        randomCard()
    end
end

cx = display.contentCenterX
cy = display.contentCenterY

-----Image
cardImage = display.newImage("1.png",cx,130)
-----Text 
options = {
    text = "Welcom",
    x = cx,
    y = cy + 70,
    width = display.contentWidth - 50,
    font = native.systemFont,
    fontSize = 16,
    align = "center"        
}

myText = display.newText(options)

---button
myButton = widget.newButton(
    {
        x =cx,
        y = 420,
        width =  150,
        height = 40,
        label = "ทำนาย",
        onEvent = handleButtonEvent,
        shape = "roundRect",
        cornerRadius = 5,
        labelColor = {default = {0,0,0}, over = {0,0,0}},
        fillColor = {default = {1,1,1,0.8}, over = {1,1,1,0.2}}
    }
)
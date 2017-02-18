local myText, myImage, card
local options
local cx, cy

local function loadImageListener(event)
    if(not event.isError)then
        if(cardImage)then
            cardImage:removeself()
            cardImage = nil
        end
        cardImage = display.newImage(
            event.response.filename,
            event.response.baseDirectory,
            cx,
            130
        )
    end
end

local function loadTextListener(event)
    if(not event.isError)then
        myText.text = event.response
    end
end

cx = display.contentCenterX
cy = display.contentCenterY

options = {
    text = "",
    x = cx,
    y = cy + 70,
    width = display.contentWidth - 50,
    font = native.systemFont,
    fontSize = 16,
    align = "center"
}

myText = display.newText(options)

card = math.random(1, 78)
network.download(
    "http://cs.pkru.ac.th/app/tarot/"..card..".png",
    "GET",
    loadImageListener,
    {},
    card .. ".png",
    system.TemperaryDirectory
)

network.request(
    "http://cs.pkru.ac.th/app/tarot/" .. card ..".txt",
    "GET",
    loadTextListener
)
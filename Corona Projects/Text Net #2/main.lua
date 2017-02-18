local myText
local options

local function networkListener(event)
    if(event.isError) then
        print("Network error!")
    else
        options = {
            text = event.response,
            x = display.contentCenterX,
            y = display.contentCenterY,
            width = display.contentWidth - 50,
            font = native.systemFont,
            fontSize = 18,
            align = "center"
        }
        myText = display.newText(options)
    end
end

network.request(
    "http://cs.pkru.ac.th/app/tarot/8.txt",
    "GET",
    networkListener
)
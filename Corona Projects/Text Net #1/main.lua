local myText

local function networkListener(event)
    if(event.isError) then
        print("Network error!")
    else
        print("Response : "..event.response)
        myText = display.newText(
            event.response,
            display.contentCenterX,
            display.contentCenterY,
            display.contentWidth - 30,
            200,
            native.systemFont, 16
        )
    end
end

network.request(
    "http://cs.pkru.ac.th/app/tarot/19.txt",
    "GET",
    networkListener
)
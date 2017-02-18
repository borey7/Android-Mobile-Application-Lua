local flagName,myImage
local params = {} --is table or array

display.setDefault("background",0,1,1)

local function loadImageListener(event)
    if(event.isError or event.status ~= 200) then
        print("Error loading...",event.status)
    else
        if(myImage)then
            myImage:removeSelf()
            myImage = nil
        end
        myImage = display.newImage(
        event.response.filename,
        event.response.baseDirectory,
        display.contentCenterX,
        100
        
        )
    end
end
local function flagNameListener(event)
    x = math.random(1,230)
    network.download(
        "http://cs.pkru.ac.th/app/flag/"..x..".png", --link to download flag
        "GET", --method of http protocal mean download
        loadImageListener,
        params,
        "flag"..x..".png", --save as flag.png
        system.TemporaryDirectory --saved location in App
    )
end

flagName = display.newText("flag",0,0,"Arial",30)
flagName.x = display.contentCenterX;flagName.y = 400
flagName:addEventListener("touch",flagNameListener)
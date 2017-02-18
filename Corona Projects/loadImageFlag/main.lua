local flagImage

local function loadImageListener(event)
    if(not event.isError)then
        flagImage = display.newImage(
            event.response.filename,
            event.response.baseDirectory,
            display.contentCenterX,
            100
        )        
    end
end

display.setDefault("background",1,1,1)

local function showFlage(event)
    network.download(
        "http://cs.pkru.ac.th/app/flag/"..math.random(1,230)..".png",
        "GET",
        loadImageListener,
        {},
        "flag.png",
        system.TemporaryDirectory
    )
end

Runtime:addEventListener("touch",showFlage)
showFlage()
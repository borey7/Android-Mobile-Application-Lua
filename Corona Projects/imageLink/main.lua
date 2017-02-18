local myImage
local function loadImageListener(event)
    if(event.isError or event.status ~= 200) then
        print("Error loading...",event.status)
    else
        myImage = display.newImage(
            event.response.filename,
            event.response.baseDirectory,
            display.contentCenterX,
            100
        )
    end
end
local params = {} --is table or array

display.setDefault("background",1,1,1)
network.download(
    "http://cs.pkru.ac.th/app/flag/115.png", --link to download flag
    "GET", --method of http protocal mean download
    loadImageListener,
    params,
    "flag.png", --save as flag.png
    system.TemporaryDirectory --saved location in App
)
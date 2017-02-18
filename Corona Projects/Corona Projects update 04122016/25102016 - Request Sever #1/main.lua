display.setDefault("background",0.3,0.4,0.5)

local JSON = require("json")
local widget = require("widget")
local textBox, play

cx = display.contentCenterX
cy = display.contentCenterY

--------------------------------------------------------

function playSound(file)
    local sound
    sound = audio.loadSound(file, system.DocumentsDirectory)
    audio.play(sound)
end

function reqMP3Listener(event)
    if (event.isError) then
        print("Download failed...")
    elseif (event.phase == "ended") then
        file = event.response.filename
        print("Saved " .. file)
        playSound(file)
    end
end

function reqURLdownload(event)
    local resp, path
    resp = event.response
    if not (event.isError) then
        path = string.match(resp, "<source src=\"(.-)\"")
        network.download(
            "http://soundoftext.com" .. path,
            "GET",
            reqMP3Listener,
            {},
            math.random(150000)..".mp3", --random name file to prevent of the same file's name
            system.DocumentsDirectory
        )
    end
end

function reqSpeechListener(event)
   	local id
    id = JSON.decode(event.response)["id"] --get id of translating
 	network.request( --request again using that id
 		"http://soundoftext.com/sounds/"..id,
 		"GET",
 		reqURLdownload,
 		{}
 	)    
end

--------------------------------------------------

local params = {}
local headers = {}

headers["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8"
headers["Accept-Language"] = "en-US"
headers["Referer"] = "http://soundoftext.com/"
params.headers = headers
--params.body = "text=hello&lang=en"

function sendRequest(event)		
	if(event.phase == "ended") then
		params.body = "text="..textBox.text.."&lang=en"
		network.request(
		    "http://soundoftext.com/sounds",
		    "POST",
		    reqSpeechListener,
	    	params
		)	
	end
end

textBox = native.newTextField(cx, cy - 100, 200 , 35)
textBox.align = "center"

myButton = widget.newButton(
    {
    	x = cx, 
    	y = cy,
        width = 200,
        height =40,
        label = "Play",
        shape = "roundedRect",
        labelColor = {default={1,1,1}, over={1,1,1}},
        fillColor = {default={0,0,0,0.5}, over={1,1,1,0.7}},
        strokeColor = {default={0,0,0,0.7}, over={1,1,1,0.5}},
        strokeWidth = 3,
        onEvent = sendRequest
    }
)



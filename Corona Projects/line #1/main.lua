--Top : wch8RMew0ROaYnsmOrGhwAbCg0qAB2SMfrTDgMJlK5y
--[[local widget = require("widget")
	local JSON = require("json")

	local cx, cy
	local txfText, btnOK
	local token = "wch8RMew0ROaYnsmOrGhwAbCg0qAB2SMfrTDgMJlK5y"

	function sendNotifyListener( event )
		local status
		if( event.phase == "ended") then
			print(event.response)
			status = JSON.decode(event.response)["status"]
			print(status)
		end
	end

	function reqSendNotify( message )
		local params = {}
		local headers = {}
		headers["Authorization"] = "Bearer ".. token
		headers["Cache-Control"] = "no-cache"
		headers["Content-Length"] = string.len(message)
		headers["Content-Type"] = "application/x-www-form-urlencoded; charset=UTF-8"
		headers["Host"] = "notify-api.line.me"
		headers["User-Agent"] = "Line-BOT"
		params.headers = headers
		params.boby = "message=" .. message.."&imageThumbnail=http://cs.pkru.ac.th/app/flag/150.png&imageFullsize=http://cs.pkru.ac.th/app/flag/150.png"
		network.request(
			"http://notify-api.line.me/api/notify",
			"POST",
			sendNotifyListener,
			params
		)
		print(message)
	end

	function buttononEvent( event )
		if(event.phase == "ended") then
			if(txfText.text ~= "") then
				reqSendNotify(txfText.text)
			end
		end
	end

	cx = display.contentCenterX
	cy = display.contentCenterY

	display.setDefault("background", 1,1,1)
	txfText = native.newTextField(cx, cy - 30, 120, 35)
	txfText.align = "center"
	btnOK = widget.newButton(
		{
			x = cx, y = cy + 50,
			onEvent = buttononEvent,
			defaultFile = "line.png"
		}
	)
	btnOK:scale(0.1,0.1)
]]
local cx,cy
local txtFill
local widget = require("widget")
local JSON = require("json")
local okButton
local token = "wch8RMew0ROaYnsmOrGhwAbCg0qAB2SMfrTDgMJlK5y"

cx = display.contentCenterX
cy = display.contentCenterY

display.setDefault("background",1,1,1)

function sendNotifyListener(event)
    local status
    if(event.phase == "ended")then
        print(event.response)
        status = JSON.decode(event.response)["status"]
        print(status)
    end
end

function reqSendNotify(message)
    local params = {}
    local headers = {}
    headers["Authorization"]= "Bearer ".. token
    headers["Cache-Control"]= "no-cache "
    headers["Content-Length"]= string.len(message)
    headers["Content-Type"]= "application/x-www-form-urlencoded; charset=UTF-8"
    headers["Host"]= "notify-api.line.me"
    headers["User-Agent"]= "Line-BOT"
    params.headers = headers
    params.body = "message=hi&imageThumbnail=http://cs.pkru.ac.th/app/flag/150.png&imageFullsize=http://cs.pkru.ac.th/app/flag/150.png"
    network.request(
        "https://notify-api.line.me/api/notify",
        "POST",
        sendNotifyListener,
        params
    )
    print(message)
end

function buttonEvent(event)
    if(event.phase == "ended") then
        if (txtFill.text ~="") then
            reqSendNotify(txtFill.text)
        end
    end
end

cx = display.contentCenterX
cy = display.contentCenterY
display.setDefault("background",1,1,1)
txtFill = native.newTextField(cx, cy * 1.2, 120, 35)
txtFill.align = "center"
okButton = display.newImage("line.png", cx, cy * 1.6)
okButton:scale(0.1,0.1)
okButton:addEventListener("touch", buttonEvent)
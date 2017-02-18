--openweathermap
--key = 5f8e19b9e43447d5ab25935d8fba8f98
--http://api.openweathermap.org/data/2.5/weather?id=1151253%2Cth&appid=9cafbb04c56b974e1bf7efcebf7a36c6&units=metric
--{"_id":1821306,"name":"Phnom Penh","country":"KH","coord":{"lon":104.916008,"lat":11.56245}}

local JSON = require("json")
local cx, cy
local name, temp, main, desc
local resp
local imgIcon
icon = ""
province_id = {"707860","519188","1270260","708546","1283710","1821306"}
id = 1
----------------------------------------------------

local function handleResponse( event )
	if not (event.isError) then
		resp = JSON.decode(event.response)
		name.text = resp["name"]
		temp.text = string.format("%.1f°C",resp["main"]["temp"])
		main.text = resp["weather"][1]["main"]
		desc.text = resp["weather"][1]["description"]
		icon = resp["weather"][1]["icon"]
		if(imgIcon)then
			imgIcon:removeSelf()
			imgIcon = nil
		end
		imgIcon = display.newImage("Media/"..icon..".png",cx ,380)
		-- imgIcon.width = 2*imgIcon.width
		-- imgIcon.height = 2*imgIcon.height
		imgIcon:scale(2,2)
	end
end

local function loadWeather()
	local cid = province_id[id]
	network.request(
		"http://api.openweathermap.org/data/2.5/weather?id="..cid.."%2Cth&appid=9cafbb04c56b974e1bf7efcebf7a36c6&units=metric",
		"GET",
		handleResponse
	)
end

local function nameListener(event)
	if (event.phase == "ended") then
		id = (id % #province_id) + 1 --#province_id count number of province_id
		loadWeather()
	end
end

display.setDefault("background", 0.3, 0.3, 0.3)
cx = display.contentCenterX
cy = display.contentCenterY
name = display.newText("name", cx, 30, "Arial", 30)
temp = display.newText("temp", cx, 130, "Arial", 75)
main = display.newText("main", cx, 260, "Arial", 40)
desc = display.newText("Description", cx, 300, "Arial", 25)
name:addEventListener("touch", nameListener)

loadWeather()

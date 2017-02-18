local widget = require("widget")
require("google-translate")

local buttonParams = {}
local buttonImage = {}
local imgGo, imgBackground, imgSpeaker, imgCheck
local txtInputNumber, tmrSplash, sndPop
local cx, cy, number, i, b, x, y

buttonParams = {
	{"0", -60, 180},
	{"1", -60, 120},
	{"2", 0, 120},
	{"3", 60, 120},
	{"4", -60, 60},
	{"5", 0, 60},
	{"6", 60, 60},
	{"7", -60, 0},
	{"8", 0, 0},
	{"9", 60, 0},
	{"b", 60, 180},
	{"c", 0, 180}	
}

local function randomNumber( )
	number = math.random(1, 9999)
	reqSpeech(number, "en")
	txtInputNumber.text = ""
end 

local function buttonListener( event )
	local buttonID = event.target.id
	local number = txtInputNumber.text
	local len = string.len(number)
	if(event.phase == "began")then
		event.target.alpha = 0.3
	elseif(event.phase=="moved")then
			event.target.alpha = 1
	elseif(event.phase=="ended")then
		event.target.alpha = 1
		if(buttonID == "c") then
			txtInputNumber.text = ""
		elseif(buttonID == "b")then
			txtInputNumber.text = number:sub(1, len-1)
		else 
			if(len < 4) then
				txtInputNumber.text = number..buttonID
			end			
		end
	end
end

local function imgSpeakerListener( event )
	if(event.phase == "began") then
		event.target.alpha = 0.3
	elseif(event.phase == "moved") then
		event.target.alpha = 1
	elseif(event.phase == "ended") then
		event.target.alpha = 1
		reqSpeech(number, "en")
	end
end

local function imgCheckListener( event )
	if(event.phase == "began")then
		event.target.alpha = 0.3
	elseif(event.phase == "moved") then
		event.target.alpha = 1
	elseif(event.phase == "ended") then
		event.target.alpha = 1
		if(txtInputNumber.text == "") then
			reqSpeech("please enter a number", "en")
			return
		end
		if(tonumber(txtInputNumber.text)==number) then
			txtInputNumber.text = ""
			randomNumber()
		else 
			reqSpeech("wrong", "en")
			txtInputNumber.text = ""
		end
	end
end 

local function loadMainScreen( )
	imgBackground = display.newImage("res/wallpaper.png",cx,cy)
	imgBackground.alpha = 0.5
	txtInputNumber = display.newText("", cx, 80, "Arial", 80)
	imgSpeaker = display.newImage("res/speaker.png", cx-50, 420)
	imgCheck = display.newImage("res/check.png",cx+50, 420)
	sndPop = audio.loadSound("res/pop.wav")	
	imgSpeaker:addEventListener("touch", imgSpeakerListener)
	imgCheck:addEventListener("touch",imgCheckListener)
	for i=1, #buttonParams do
		b = buttonParams[i][1]
		x = buttonParams[i][2]
		y = buttonParams[i][3]
		buttonImage[i] = display.newImage("res/"..b..".png",cx+x, cy+y - 70)
		buttonImage[i].id = b
		buttonImage[i]:addEventListener("touch",buttonListener)
	end
	randomNumber()
end

local function imgGoListener( event )
	timer.cancel(tmrSplash)
	imgBackground:removeSelf()
	imgBackground = nil
	imgGo:removeSelf()
	imgGo = nil
	loadMainScreen()
end

display.setDefault("background",255/255, 195/255, 20/255)
cx = display.contentCenterX
cy = display.contentCenterY
imgBackground = display.newImage("res/intro.png",cx, cy)
imgGo = display.newImage("res/go.png", cx, cy+100)
imgGo:addEventListener("touch", imgGoListener)
tmrSplash = timer.performWithDelay(10000, imgGoListener, 1)
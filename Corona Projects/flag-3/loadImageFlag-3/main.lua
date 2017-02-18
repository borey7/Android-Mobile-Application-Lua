local widget = require("widget")

local flagImage, flag1, flag2, trueFlag, trueButton
local randomFlag, loadFlagImage, loadFlagName1, loadFlagName2
local click, buzz
local button1, button2

local function touchImage(event)
	if (event.phase == "ended") then
		randomFlag()
	end
end

function loadFlagImage(event)
	if (not event.isError) then
		flagImage = display.newImage(
			event.response.filename, 
			event.response.baseDirectory, 
			display.contentCenterX,
			125
		)
		flagImage:setStrokeColor(0.5, 0.5, 0.5, 0.5)
		flagImage.strokeWidth = 1
		flagImage:addEventListener("touch", touchImage)
	end
end

function loadFlagName1(event)
	if (not event.isError) then
		button1:setLabel(event.response)
	end
end

function loadFlagName2(event)
	if (not event.isError) then
		button2:setLabel(event.response)
	end
end

function randomFlag()

	flag1 = math.random(1, 230)
	flag2 = math.random(1, 230)
	trueButton = math.random(1, 2)
	if (trueButton == 1) then
		trueFlag = flag1
	else
		trueFlag = flag2
	end
	
	if (flagImage) then
		flagImage:removeSelf()
		flagImage = nil
	end

	network.download(
		"http://cs.pkru.ac.th/app/flag/" .. trueFlag .. ".png",
		"GET",
		loadFlagImage,
		{},
		trueFlag .. ".png",
		system.TemporaryDirectory
	)
	network.request( 
		"http://cs.pkru.ac.th/app/flag/" .. flag1 .. ".txt", 
		"GET", 
		loadFlagName1
	)
	network.request( 
		"http://cs.pkru.ac.th/app/flag/" .. flag2 .. ".txt", 
		"GET", 
		loadFlagName2
	)
end

local function clickButton(event)
	local button = event.target.id
	if (event.phase == "ended") then
		print("trueflag = " .. trueFlag)
		print("button = " .. button)
		if 	(button == "button1" and trueButton == 1) or 
			(button == "button2" and trueButton == 2) then
			audio.play(click)
			randomFlag()
		else
			audio.play(buzz)
		end
	end
end

local function init()
	button1 = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 350,
			width = 280,
			shape = "Rectangle",
			label = "",
			id = "button1",
			labelColor = { default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={0.5, 0.5, 0.5, 1}, over={1, 1, 1, 1} },
			onEvent = clickButton
		}
	)
	button2 = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 410,
			width = 280,
			shape = "Rectangle",
			label = "",
			id = "button2",
			labelColor = { default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={0.5, 0.5, 0.5, 1}, over={1, 1, 1, 1} },
			onEvent = clickButton
		}
	)	

	display.setDefault( "background", 1, 1, 1)
	buzz = audio.loadSound("buzz.mp3")
	click = audio.loadSound("click.mp3")

end

init()
randomFlag()
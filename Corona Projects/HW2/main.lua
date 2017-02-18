local widget = require("widget")

local flagImage, flag1, flag2, flag3, flag4, trueFlag, trueButton
local randomFlag, loadFlagImage, loadFlagName1, loadFlagName2, loadFlagName3, loadFlagName4
local button1, button2, button3, button4
local result = {}
right = 0
wrong = 0
cx = display.contentCenterX
cy = display.contentCenterY
local timeCounter, showTime
timeUsing = 0

local function loadTime(event)
	 if(showTime) then	
		showTime:removeSelf()
		showTime = nil						
	end
	showTime = display.newText(timeUsing,cx,0,"Arial",36)
	showTime:setTextColor(0,0,0)		
	timeUsing = timeUsing + 1
end

local function finishGame(event)
    button1:removeSelf()
    button1 = nil
    button2:removeSelf()
    button2 = nil
    button3:removeSelf()
    button3 = nil
    button4:removeSelf()
    button4 = nil
    if(flagImage)then
        flagImage:removeSelf()
        flagImage = nil
    end

	if(timeCounter) then
		timer.cancel(timeCounter)
		timeCounter = nil		
	end
	if(showTime) then	
		showTime:removeSelf()
		showTime = nil						
	end

    print("right : "..right.." wrong : "..wrong)
    result[1] = display.newText("Right choice = "..right,cx,cy-60,"Arial",25)
    result[2] = display.newText("Wrong choice = "..wrong,cx,cy-30,"Arial",25)    
	result[3] = display.newText("Time = "..timeUsing,cx,cy,"Arial",25)
	result[4] = display.newText("Score = "..(right+right*right/timeUsing),cx,cy+60,"Arial",25)
    result[1]:setTextColor(0,0,0)
    result[2]:setTextColor(0,0,0)    
	result[3]:setTextColor(0,0,0)
	result[4]:setTextColor(0,0,0)
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
function loadFlagName3(event)
	if (not event.isError) then
		button3:setLabel(event.response)
	end
end
function loadFlagName4(event)
	if (not event.isError) then
		button4:setLabel(event.response)
	end
end

function randomFlag()
	flag1 = math.random(1, 230)
	flag2 = math.random(1, 230)
    flag3 = math.random(1, 230)
    flag4 = math.random(1, 230)
	trueButton = math.random(1, 4)
	if (trueButton == 1) then
		trueFlag = flag1
	elseif (trueButton == 2) then
		trueFlag = flag2
	elseif(trueButton == 3) then
        trueFlag = flag3
    else
        trueFlag = flag4
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
    network.request( 
        "http://cs.pkru.ac.th/app/flag/" .. flag3 .. ".txt", 
        "GET", 
        loadFlagName3
    )
    network.request( 
        "http://cs.pkru.ac.th/app/flag/" .. flag4 .. ".txt", 
        "GET", 
        loadFlagName4
    )
end

local function clickButton(event)
	local button = event.target.id	
	if (event.phase == "ended") then
		print("trueflag = " .. trueFlag)
		print("button = " .. button)
        if (right+wrong==10) then
            finishGame()
		elseif 	(button == "button1" and trueButton == 1) or 
			(button == "button2" and trueButton == 2) or
            (button == "button3" and trueButton == 3) or
            (button == "button4" and trueButton == 4) then
            right = right + 1            
			randomFlag()
		else
            wrong = wrong + 1
            randomFlag()
		end		        
	end
end

local function init()
	button1 = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 250,
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
			top = 310,
			width = 280,
			shape = "Rectangle",
			label = "",
			id = "button2",
			labelColor = { default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={0.5, 0.5, 0.5, 1}, over={1, 1, 1, 1} },
			onEvent = clickButton
		}
	)	
    button3 = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 370,
			width = 280,
			shape = "Rectangle",
			label = "",
			id = "button3",
			labelColor = { default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={0.5, 0.5, 0.5, 1}, over={1, 1, 1, 1} },
			onEvent = clickButton
		}
	)	
    button4 = widget.newButton( {
			left = display.contentCenterX - (280 / 2),
			top = 430,
			width = 280,
			shape = "Rectangle",
			label = "",
			id = "button4",
			labelColor = { default={1, 1, 1, 1}, over={0, 0, 0, 1} },
			fillColor = { default={0.5, 0.5, 0.5, 1}, over={1, 1, 1, 1} },
			onEvent = clickButton
		}
	)
	display.setDefault( "background", 1, 1, 1)
end

timeCounter = timer.performWithDelay(1000, loadTime, 0) 
init()
randomFlag()
local widget = require("widget")
local composer = require("composer")
local scene = composer.newScene()
local scrollView, titleText, myText, contents
local path, file

local function screenTouched(event)
	local phase = event.phase
	local xStart = event.xStart
	local xEnd = event.x
	local swipeLength = math.abs(xEnd - xStart) 
	if (phase == "began") then
		return true
	elseif (phase == "ended" or phase == "cancelled") then
		if (xStart > xEnd and swipeLength > 50) then 
			composer.gotoScene("scene1")
		elseif (xStart < xEnd and swipeLength > 50) then 
			composer.gotoScene("scene2")
		end 
	end	
end

function scene:create(event)
	local sceneGroup = self.view
end

local function scrollViewListener(event)
	local xStart = event.xStart
	local xEnd = event.x
	local swipeLength
	if (event.phase == "began") then
		return true
	elseif (event.phase == "ended" or event.phase == "cancelled") then	
		swipeLength = math.abs(xEnd - xStart) 
		if (xStart > xEnd and swipeLength > 50) then 
			composer.gotoScene("scene1")
		elseif (xStart < xEnd and swipeLength > 50) then 
			composer.gotoScene("scene2")
		end 
	end	

	if (xStart ~= nil) and (xEnd ~= nil) then
		swipeLength = math.abs(xEnd - xStart) 
	end
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then
		display.setDefault("background", 77 / 255, 86 / 255, 86 / 255)
		path = system.pathForFile("bmi.txt", system.ResourceDirectory)
		file, err = io.open(path, "r")

		if (file) then
			contents = file:read("*a")
			io.close(file)
			file = nil
		else
			contents = "* ERROR *"
		end

		scrollView = widget.newScrollView( 
			{
				top = 100,
				left = 0,
				width = display.contentWidth,
				height = display.contentHeight,
				topPadding = 20,
				bottomPadding = 20,
				horizontalScrollDisabled = true,
				hideBackground = true,
				listener = scrollViewListener
			}
		)

		display.setDefault("background", 77 / 255, 86 / 255, 86 / 255)
		titleText = display.newText("BMI", display.contentCenterX, 70, "Quark-Bold", 80)
		myText = display.newText(contents, 0, 0, display.contentWidth - 40, 1200, "Quark-Bold", 18)
		myText.anchorY = 0
		myText:setTextColor(1, 1, 1)
		myText.x = display.contentCenterX
		scrollView:insert(myText)
		sceneGroup:insert(scrollView)

	elseif (phase == "did") then
		Runtime:addEventListener("touch", screenTouched)
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then
		titleText:removeSelf()
		titleText = nil
		scrollView:removeSelf()
		scrollView = nil
		Runtime:removeEventListener("touch", screenTouched)
	elseif (phase == "did") then
	end
end

function scene:destroy(event)
	local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
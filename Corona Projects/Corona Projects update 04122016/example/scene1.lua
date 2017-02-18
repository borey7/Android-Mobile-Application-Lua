local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()
local titleText, hTextField, wTextField, bmiText

local function screenTouched(event)
	local phase = event.phase
	local xStart = event.xStart
	local xEnd = event.x
	local swipeLength = math.abs(xEnd - xStart) 
	if (phase == "began") then
		return true
	elseif (phase == "ended" or phase == "cancelled") then
		if (xStart > xEnd and swipeLength > 50) then 
			composer.gotoScene("scene2")
		elseif (xStart < xEnd and swipeLength > 50) then 
			composer.gotoScene("scene3")
		end 
	end	
end

local function calculateBMI(event)
	local h = tonumber(hTextField.text)
	local w = tonumber(wTextField.text)
	if (h == nil or w == nil or h <= 0 or w <= 0) then
		bmiText.text = "0.00"
		return
	end
	bmiText.text = string.format( "%6.2f", w / (h/100 * h/100))
end

function scene:create(event)
	local sceneGroup = self.view
end

local function textFieldHandler(event)
	calculateBMI(event)
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	local cx, cy
	cx = display.contentCenterX
	cy = display.contentCenterY
	if (phase == "will") then
		display.setDefault("background", 77 / 255, 86 / 255, 86 / 255)
		titleText = display.newText("BMI", cx, 100, "Quark-Bold", 80)
		hTextField = native.newTextField(cx, 180, 130, 40)
		wTextField = native.newTextField(cx, 230, 130, 40)
		hTextField.inputType = "number"
		wTextField.inputType = "number"
		hTextField.align = "center"
		wTextField.align = "center"
		bmiText = display.newText("0.00", cx, 300, "Quark-Bold", 50)
		sceneGroup:insert(titleText)
		sceneGroup:insert(bmiText)
		hTextField.text = composer.getVariable("hSave")
		wTextField.text = composer.getVariable("wSave")
		calculateBMI()		
	elseif (phase == "did") then	
		hTextField:addEventListener("userInput", textFieldHandler)	
		wTextField:addEventListener("userInput", textFieldHandler)	
		Runtime:addEventListener("touch", screenTouched)
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then
		composer.setVariable("hSave", hTextField.text)
		composer.setVariable("wSave", wTextField.text)
		hTextField:removeEventListener("userInput", textFieldHandler)	
		wTextField:removeEventListener("userInput", textFieldHandler)	
		titleText:removeSelf()
		hTextField:removeSelf()
		wTextField:removeSelf()
		bmiText:removeSelf()
		titleText = nil
		hTextField = nil
		wTextField = nil
		calButton = nil
		bmiText = nil
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
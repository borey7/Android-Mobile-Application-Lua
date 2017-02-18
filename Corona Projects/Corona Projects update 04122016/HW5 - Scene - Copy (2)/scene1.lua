local composer = require("composer")
local widget = require("widget")
local scene = composer.newScene()
local titleText, hTextField, wTextField, creditText, year, sem

local h = 0
local w = 0
local hw = 0

local function screenTouched(event)
	local phase = event.phase
	local xStart = event.xStart
	local xEnd = event.x
	local swipeLength = math.abs(xEnd - xStart) 
	if (phase == "began") then
		return true
	elseif (phase == "ended" or phase == "cancelled") then
		if (xStart > xEnd and swipeLength > 50) then 
			composer.gotoScene("scene2" , {effect = "fade", time = 200})
		elseif (xStart < xEnd and swipeLength > 50) then 
			composer.gotoScene("scene3", {effect = "fade", time = 200})
		end 
	end	
end

local function calculateCredit(event)
	h = tonumber(hTextField.text)
	w = tonumber(wTextField.text)

	if not ( h==nil) then hw = h*10 else hw = 0 end
	--if w>10 h+w can be 21, 22,... example h=1 w=12 hw=32
	if not (w==nil) then if 0<w and w<3 then hw = hw + w end end

	if w==nil or (0<w and w<3) then
		if( hw == 0 ) then creditText.text = "0"
		elseif( hw == 10 ) then creditText.text = "38/41 Credits"
		elseif( hw == 11 ) then creditText.text = "17/20 Credits"
		elseif( hw == 12 ) then creditText.text = "21 Credits"
		elseif( hw == 20 ) then creditText.text = "38/41 Credits"
		elseif( hw == 21 ) then creditText.text = "17/20 Credits"
		elseif( hw == 22 ) then creditText.text = "21 Credits"
		elseif( hw == 30 ) then creditText.text = "39 Credits"
		elseif( hw == 31 ) then creditText.text = "21 Credits"
		elseif( hw == 32 ) then creditText.text = "18 Credits"
		elseif( hw == 40 ) then creditText.text = "16 Credits"
		elseif( hw == 41 ) then creditText.text = "6 Credits"
		elseif( hw == 42 ) then creditText.text = "10 Credits"
		else creditText.text = "Not available" end		
	else creditText.text = "Not available" end		
	return
end

function scene:create(event)
	local sceneGroup = self.view
end

local function textFieldHandler(event)
	calculateCredit(event)
end

function lookforsubject(event)	
	if(event.phase == "ended") then		
		if w==nil or (0<w and w<3) then		
			if(hw==10 or hw==20 or hw==30 or hw==40) then
				scene1Click = true
				subjbysem = (hw/10).."%"
				composer.gotoScene("scene2" , {effect = "fade", time = 200})			
			elseif(hw==11 or hw==12 or hw==21 or hw==22 or hw==31 or hw==32 or hw==41 or hw==42) then
				scene1Click = true
				subjbysem = hw
				composer.gotoScene("scene2" , {effect = "fade", time = 200})
			end	
		end
	end	
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	local cx, cy
	cx = display.contentCenterX
	cy = display.contentCenterY
	if (phase == "will") then
		display.setDefault("background", 0.3, 0.4, 0.5)
		titleText = display.newText("Credit", cx, 100, "Quark-Bold", 80)
		year = display.newText("Year", cx, 160, "Quark-Bold", 30) -- year		
		hTextField = native.newTextField(cx, 190, 130, 40)
		--hTextField = native.newTextField(cx, 180, 130, 40)
		sem = display.newText("Semester", cx, 240, "Quark-Bold", 30) --semester		
		wTextField = native.newTextField(cx, 270, 130, 40)
		--wTextField = native.newTextField(cx, 230, 130, 40)
		hTextField.inputType = "number"
		wTextField.inputType = "number"
		hTextField.align = "center"
		wTextField.align = "center"
		creditText = display.newText("Credit", cx, 330, "Quark-Bold", 50)	
		creditText:addEventListener("touch", lookforsubject)	
		sceneGroup:insert(year)
		sceneGroup:insert(sem)
		sceneGroup:insert(titleText)
		sceneGroup:insert(creditText)
		hTextField.text = composer.getVariable("hSave")
		wTextField.text = composer.getVariable("wSave")
		calculateCredit()		
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
		creditText:removeSelf()
		titleText = nil
		hTextField = nil
		wTextField = nil
		calButton = nil
		creditText = nil
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
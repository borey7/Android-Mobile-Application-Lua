local composer = require("composer")
composer.setVariable("hSave", "") -- declare variable (can use in all scense)
composer.setVariable("wSave", "")
composer.setVariable("subjbysem", "")
composer.setVariable("scene1Click", false)

display.setDefault("background", 0.3, 0.4, 0.5)
local obj = {}
cx = display.contentCenterX 
cy = display.contentCenterY

function show( item, t, x2, y2 )
	if(x2==0) then transition.to(item, {time = t, y = y2})	
	else transition.to(item, {time = t, x = x2})	end
end

obj[1] = display.newImage("Logo_PSU.png", -60 , 130)
obj[1]:scale(0.7, 0.7)
timer.performWithDelay(0, show(obj[1] , 1000, cx - 60, 0), 1)

obj[2] = display.newImage("Logo_TE.png",cx*2+60, 140)
obj[2]:scale(0.2,0.2)
timer.performWithDelay(1000, show(obj[2] , 1000, cx + 60, 0), 1)

obj[3] = display.newText("Curriculum", cx, cy-10 + 60, "Quark-Bold", 30)
timer.performWithDelay(1000, show(obj[3] , 500, 0, cy - 10), 1)

obj[4] = display.newText("Information", cx, cy + 50 + 60, "Quark-Bold", 50)
timer.performWithDelay(2000, show(obj[4] , 600, 0, cy + 50), 1)

obj[5] = display.newText("Technology", cx, cy + 100 + 60, "Quark-Bold", 50)
timer.performWithDelay(2000, show(obj[5] , 700, 0, cy + 100), 1)

function start( )
	for i=1, #obj do		
		if(obj[i]) then
			obj[i]:removeSelf()
			obj[i] = nil
		end
	end
	composer.gotoScene("scene3", {effect = "fade", time = 500})
end
timer.performWithDelay(2000, start, 1)
--native.setKeyBoardFocus(txfAnswer)

local widget = require("widget")
local imagWrong, imageRight
local homegroup, group1, group2, activeGroup
local  txtQuestion, txfAnswer, btnOK
local x, y, z, op, theAnswer, answer
local cx, cy
score = 0
wrong = 1

local  img
img = display.newImage("IMG/right.png", cx, 180)	
homegroup = display.newGroup()

local function loadImage()
	imageWrong = display.newImage("IMG/wrong.png", cx, 180)
	imageRight = display.newImage("IMG/right.png", cx, 180)	
	group1 = display.newGroup()
	group2 = display.newGroup()
	group = display.newGroup()
	group1:insert(imageWrong)
	group2:insert(imageRight)
	group1.isVisible = false
	group2.isVisible = false
end

local function randomQuestion()	
	x = math.random(1, 9)
	y = math.random(1, 9)
	op = math.random(1, 3)
	if(op == 1) then
		question = x.."+"..y
		theAnswer = x+y
	elseif(op == 2) then
		question = x.."-"..y
		theAnswer = x-y
	else
		question = x.."x"..y
		theAnswer = x*y	
	end
	txtQuestion.text = question
end
display.setDefault("background",1, 1, 1)
cx = display.contentCenterX
cy = display.contentCenterY

txtQuestion = display.newText("9 + 9", cx, 100, "Arial", 80)
txtQuestion:setFillColor(0)
txfAnswer = native.newTextField(cx, 200, 120, 80) --x,y,with,height
txfAnswer.align = "center"

local function hideToast()
	activegroup.isVisible = false
	txfAnswer.isVisible = true
	homegroup.isVisible = true		
	randomQuestion()
	txfAnswer.text = ""
	native.setKeyboardFocus(txfAnswer)	
end

local  function showToast()
	activegroup.isVisible = true
	txfAnswer.isVisible = false
	homegroup.isVisible = false
end

local function toast(obj)
	activegroup = obj
	showToast()
	timer.performWithDelay(500, hideToast, 1);
end

local  function buttonEvent(event)
	if(event.phase == "ended") then
		answer = tonumber(txfAnswer.text)	
		print(answer)	
		print(theAnswer)
		if(theAnswer == answer) then
			toast(group2)				
			score = score + 1		
			wrong = 0
		else		
			wrong = wrong%5 + 1			
			toast(group1)			
		end	
		randomQuestion()
	end
end

btnOK = widget.newButton(
	{	
		x = cx,
		y = 300,
		onEvent = buttonEvent,
		defaultFile = "IMG/check.png"
	}
)
--txfAnswer.isVisible = false
homegroup:insert(txtQuestion)
homegroup:insert(txfAnswer)
homegroup:insert(btnOK)

native.setKeyboardFocus(txfAnswer)	
loadImage()
randomQuestion()
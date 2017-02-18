-- local is variable for object
local myText1, myText2, myText3, myText4

-- function must write on the top of calling
local function text1Listener(event)
    myText1.text = "528"
end
local function text2Listener(event)
    myText2.text = "624"    
end
local function text3Listener(event)
    myText3.text = "284"    
end
local function text4Listener(event)
    myText4.text = "962"
end

myText1 = display.newText("Bangkok",0,0,"Arial",30)
myText2 = display.newText("Chiang Mai",0,0,"Arial",30)
myText3 = display.newText("Songkhla",0,0,"Arial",30)
myText4 = display.newText("Khonkaen",0,0,"Arial",30)

myText1.x = display.contentCenterX;myText1.y = 120
myText2.x = display.contentCenterX;myText2.y = 160
myText3.x = display.contentCenterX;myText3.y = 200
myText4.x = display.contentCenterX;myText4.y = 240

myText1:addEventListener("touch",text1Listener)
myText2:addEventListener("touch",text2Listener)
myText3:addEventListener("touch",text3Listener)
myText4:addEventListener("touch",text4Listener)
local widget = require("widget")
local f_name, l_name, f_name_text, l_name_text, title
local cx, cy
local alphabetTimer

playing = false
len = 0
pos = 0
addAlphabet = {}

local function setAsDefault(event)
    --remove object
    pos = 0
    for i=1 , #addAlphabet do
        if(addAlphabet[i])then            
            addAlphabet[i]:removeSelf()
            addAlphabet[i]=nil
        end
    end
        
    --remove trigger
    if(alphabetTimer)then
        timer.cancel(alphabetTimer)
        alphabetTimer = nil
    end

    --textfield defaul properties
    transition.to(f_name, {time=700,x=cx})
    transition.to(l_name, {time=700,x=cx})
    
    --text defaul properties
    transition.to(f_name_text, {time=500,y=cy-170})
    transition.to(l_name_text, {time=500,y=cy-100})
    transition.to(title, {time=700,x=cx})
    f_name_text.text = "First Name :"
    l_name_text.text = "Last Name :"

    --button defaul position
    transition.to(goButton, {time=500,y=cy+30})
    goButton.rotation = 0
end

local function changeItemsProperties(event)
    transition.to(goButton, {time=500,y=cy+4*cy/5})                        
    goButton.rotation = 180                  
    transition.to(f_name, {time=700,x=cx*3})
    transition.to(l_name, {time=700,x=-cx*3})
    transition.to(title, {time=700,x=cx*3})
    transition.to(f_name_text, {time=500,y=f_name_text.y-30})
    transition.to(l_name_text, {time=700,y=l_name_text.y-60})
    f_name_text.text = f_name.text
    l_name_text.text = l_name.text
end

local function showAlphabet(event)
    if(playing) then
        if(pos >= len) then            
            playing = false
            setAsDefault()                                                                        
        else                    
            transition.to(addAlphabet[pos+1], {time = 700, x = -cx*2})            
            pos = pos + 1 
            if(pos < len) then
                 transition.to(addAlphabet[pos+1], {time = 300, x = cx})
            end                                                                    
        end
    end
end

local function spellName(event)

    --create alphabet object equeal to name length
    addAlphabet = {}          
    name = string.lower(" "..f_name.text..l_name.text.." ")
    len = string.len(name)                          
    for i=1, len do
        if(i==1 or i==len)then
            table.insert(addAlphabet, display.newImage("img/start_end.png", cx*3,cy))
        elseif (string.byte(name,i)<97 or 122<string.byte(name,i))then
            table.insert(addAlphabet, display.newImage("img/alphabet/error.png", cx*3,cy))
        else
            table.insert(addAlphabet, display.newImage("img/alphabet/"..name:sub(i,i)..".png", cx*3,cy))
        end
    end        

    --show alphabet
    addAlphabet[1].x = cx
    alphabetTimer = timer.performWithDelay(500, showAlphabet, 0) 
end

local function playButtonEventHandler(event)
    if(event.phase == "ended") then        
        if(not playing) then
            playing = true
            changeItemsProperties()
            spellName()
        else
            playing = false        
            setAsDefault()                                                                              
        end
    end
end

display.setDefault("background", 0.5, 0.5, 0.5)
cx = display.contentCenterX
cy = display.contentCenterY

--first name
f_name_text = display.newText("First Name :",cx,cy-170,"Arial",20)
f_name = native.newTextField(cx,cy-140,180,30)
f_name.align = "center"

--last name
l_name_text = display.newText("Last Name :",cx,cy-100,"Arial",20)
l_name = native.newTextField(cx,cy-70,180,30)
l_name.align = "center"

--button
goButton = display.newImage("img/play.png",cx,cy+30)
goButton:addEventListener("touch",playButtonEventHandler)

--title
title = display.newText("Spell Your Name",cx,cy+2*cy/3,"Arial",30)
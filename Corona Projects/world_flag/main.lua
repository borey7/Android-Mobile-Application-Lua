local country_name,flag;

local function coutry_flag(event)
    x = 1
    if(flag) then
        flag:removeSelf()
        flag = nil
    end
    if(x==1) then
        flag = display.newImage("cambodia.png")    
    elseif(x==2) then
        flag = display.newImage("thailand.png")    
    elseif(x==3) then
        flag = display.newImage("vietnam.png")    
    elseif(x==4) then
        flag = display.newImage("laos.png")    
    elseif(x==5) then
        flag = display.newImage("myanmar.png")    
    else 
        flag = display.newImage("singapore.png")
    end    
    flag.x = display.contentCenterX;flag.y = display.contentCenterY/2
end

country_name = display.newText("coutry",0,0,"Arial",30)
country_name.x = display.contentCenterX; country_name.y = display.contentCenterY+display.contentCenterY/2
country_name:addEventListener("touch",coutry_flag)
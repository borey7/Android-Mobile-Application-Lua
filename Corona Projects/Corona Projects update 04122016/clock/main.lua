cx = display.contentCenterX
cy = display.contentCenterY
--------------------------
display.setDefault("background",0,0,0)

local timenumber = display.newImage("resource/timenumber.png", cx-50, cy-150)
local wise_sec = display.newImage("resource/wise-second.png", cx-50, cy-150)
timenumber:scale(0.4, 0.4)
wise_sec:scale(0.4, 0.4)

arc = 180
wise_sec.rotation = arc    
local function rockRect()	
	wise_sec.rotation = arc    
	arc = (arc + 5)%360
end
timer.performWithDelay( 1000, rockRect, 0 )

---------------------------------------
local defaultField

local function textListener( event )

    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"

    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        print( event.target.text )

    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end
end

-- Create text field
defaultField = native.newTextField( 150, 150, 180, 30 )
defaultField:addEventListener( "userInput", textListener )
local composer = require("composer")
local scene = composer.newScene()

function scene:create(event)
    local sceneGroup = self.view
    print("Scene #2 : create")
end

local function showScene()
    composer.gotoScene("view3", {effect = "fade", time = 500})
end

local function screenTouched( event )
   local phase = event.phase
   local xStart = event.xStart
   local xEnd = event.x
   local swipelLength = math.abs(xEnd - xStart)
   if(phase=='began')then
        return true
    elseif(phase=='ended' or phase=='cancelled') then
        if(xStart > xEnd and swipelLength > 50) then
            composer.gotoScene('view3', {effect = "fromRight", time = 500})
        elseif(xStart < xEnd and swipelLength > 50) then
            composer.gotoScene("view1", {effect = "fromLeft", time = 500})
        end
   end   
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        print("Scene #2: show (will)")
        background = display.setDefault("background", 1, 1, 0)
        myText = display.newText("View #2", 160, 240 -50, "Arial", 50)
        sceneGroup:insert(myText)
    elseif (phase == "did") then
        print("Scene #2 :show (did)")
        --timer.performWithDelay(1000, showScene)
        Runtime:addEventListener('touch', screenTouched)
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
        print("Scene #2 : hide (will)")
        myText:removeSelf()
        myText = nil
        Runtime:removeEventListener('touch', screenTouched)
    elseif (phase == "did") then
        print("Scene #2 : hide (did)")
    end
end

function scene:distroy(event)
    local sceneGroup = self.view
    local phase = event.phase
    print("Scene #2 : destroy (will)")
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

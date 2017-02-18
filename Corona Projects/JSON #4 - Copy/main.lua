local widget = require("widget")
local JSON = require("json")
local cx, cy, txtTranslate, txfWord, button
local translate

local function JSONFile2Table(filename)
    local path, file, contents
    path = system.pathForFile(filename, system.DocumentsDirectory)
    file = io.open(path, "r")
    if (file) then
        contents = file:read("*a")        
        io.close(file)
        return contents
    end
    return nil
end

local function loadJSONListener(event)
    if (event.isError) then
        print("Download failed...")
    elseif (event.phase == "ended") then
        print("Saved " .. event.response.filename)
        translate = JSON.decode(JSONFile2Table("translate.json"))
        txtTranslate.text = translate["text"][1]
    end
end

local function doTranslate(word)
    network.download(
        "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160927T025338Z.68dd354dfe623f89.15aa3c6fd8f24a9360a250e3d898bc5ccbfe2951&text=" .. word .. "&lang=en-th",
        "GET",
        loadJSONListener,
        {},
        "translate.json",
        system.DocumentsDirectory
    )
end

local function buttonEvent(event)
    if (event.phase == "ended") then
        doTranslate(txfWord.text)
    end
end

display.setDefault("background", 1, 1, 1)
cx = display.contentCenterX
cy = display.contentCenterY
txtTranslate = display.newText("English > ไทย", cx, 130,"Arial", 30)
txtTranslate:setFillColor(0)
txfWord = native.newTextField(cx, 200, 200, 40)
txfWord.align = "center"

button = widget.newButton(
    {
        x = cx, y = 280,
        onEvent = buttonEvent,
        defaultFile = "check.png",        
    }
)
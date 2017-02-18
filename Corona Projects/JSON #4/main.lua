local widget = require("widget")
local JSON = require("json")
local cx, cy, txtTranslate, txfWord, button
local translate
local showError
local lang1Title, lang2Title, textMeaning, changeLang
lang1 = "English" 
lang2 = "Thai"
meaning = ""
key = "en-th"
responseCode = 0
errorMessage = "The text cannot be translated"

local bg = display.newImage("background.jpg",0,0)
bg.x = 270
bg.y = 270

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
        responseCode = translate["code"]
        --txtTranslate.text = translate["text"][1]
        textMeaning.text = translate["text"][1]

        print(responseCode)
        if(responseCode == 200) then
        	translate.text = translate["text"][1]
        elseif(responseCode == 422) then 	
	        if(showError) then
	        	showError:removeSelf()
	        	showError = nil
	        end
           	showError = display.newText(errorMessage, cx, cy*2 - 200, "Arial", 35);
        	showError:setFillColor(0,0,1)
        end
    end
end



local function doTranslate(word)
    network.download(
        "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160927T113237Z.f287a7e1869b8e4d.b13690fd5eaba0612cc507026153cf3971a3b454&text=" .. word .. "&lang="..key,
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

local function changeLangEvent(event)
	if(event.phase == "ended") then
		print("clicked")
		if(key == "en-th") then 
			key = "th-en" 
			changeLang:setLabel("Thai - English")
			lang1Title.text = "Thai"
			lang2Title.text = "English"
		else 
			key = "en-th" 
			changeLang:setLabel("English - Thai")
			lang1Title.text = "English"
			lang2Title.text = "Thai"
		end
	end
end

changeLang = widget.newButton(
    {
        x = cx,
        y = 10,
        width = 150,
        height =40,
        id = "changeLang",
        label = "English - Thai",
        onEvent = changeLangEvent,
        shape = "Rect",
        labelColor = {default={1,1,1}, over={0,0,0,0.5}},        
        fillColor = {default={0.4,0.4,0.4}, over={0.8,0.8,0.8}}            
    }
)

display.setDefault("background", 1, 1, 1)
cx = display.contentCenterX
cy = display.contentCenterY
lang1Title = display.newText(lang1.." : ", cx, cy - 150,"Arial", 30)
lang1Title:setFillColor(0,0,1)
txfWord = native.newTextField(cx - 40, cy - 70, 200, 40)
txfWord.align = "center"

lang2Title = display.newText(lang2.." : ", cx, cy - 10,"Arial", 30)
lang2Title:setFillColor(0,0,1)
textMeaning = display.newText(meaning, cx, 300,"Arial", 30)
textMeaning:setFillColor(0)

button = widget.newButton(
    {
        x = cx+110, y = cy - 70,
        width = 60,
        height =60,
        onEvent = buttonEvent,
        defaultFile = "translateIcon1.png",        
    }
)

--errorMessage = doTranslate(errorMessage)
print(errorMessage)
local widget = require("widget")
require("google-translate")

local vocab = {}
local cx, p, n, vocabTitle, vocabPos, clickSound

local function vocabImage()
    return string.gsub(vocab[p], ".png", "")
end

local function imageTouch(event)
    if (event.phase == "ended") then
        reqTranslate(vocabImage(), "en")
    end
end

function changeImage(event)
    if (event.phase == "ended") then
        if (image) then
            image:removeSelf()
            image = nil
        end
        image = display.newImage(event.response.filename,
            system.DocumentsDirectory)
        image:translate(cx, 220)
        image:addEventListener("touch", imageTouch)
    end
end

local function loadImageVocab()
    local params = {}
    local imageFile = vocab[p]
    local url = "http://www.phuketsmartcity.com/app/vocab/" .. imageFile
    network.download(
        url,
        "GET",
        changeImage,
        params,
        imageFile,
        system.DocumentsDirectory)
    vocabPos.text = p .. " of " .. n
    vocabTitle.text = vocabImage()
end

local function updatePos(x)
    p = p + x
    if(p > n) then
        p = 1
    elseif(p < 1) then
        p = n
    end
end

local function loadTextVocab()
    local path = system.pathForFile("res/vocab.txt", system.ResourceDirectory)
    local file = io.open(path, "r")
    if (file) then
        for line in file:lines() do
            vocab[#vocab + 1] = line;
        end
        io.close(file)
        file = nil
        n = #vocab
    else
        print("Error loading file..")
        n = 0
    end
end

local function buttonPress(event)
    local button = event.target.id
    if (event.phase == "ended") then
        audio.play(clickSound)
        if (button == "next") then
            updatePos(1)
        elseif (button == "prev") then
            updatePos(-1)
        else
            p = math.random(1, n)
        end
        loadImageVocab()
    end
end

local randButton = widget.newButton(
    {
        defaultFile = "res/fly.png",
        overFile = "res/fly-over.png",
        id = "rand",
        onEvent = buttonPress
    }
)

local prevButton = widget.newButton(
    {
        defaultFile = "res/prev.png",
        overFile = "res/prev-over.png",
        id = "prev",
        onEvent = buttonPress
    }
)

local nextButton = widget.newButton(
    {
        defaultFile = "res/next.png",
        overFile = "res/next-over.png",
        id = "next",
        onEvent = buttonPress
    }
)

cx = display.contentCenterX

randButton.x = cx
prevButton.x = cx - 100
nextButton.x = cx + 100

randButton.y = 450
prevButton.y = 450
nextButton.y = 450

loadTextVocab()
clickSound = audio.loadSound("res/click.mp3")

p = 1
display.setDefault("background", 255/255, 195/255, 20/255)
vocabTitle = display.newText("", cx, 50, "Arial", 40)
vocabPos = display.newText("1 of " .. n, cx, 380, "Arial", 40)
vocabTitle:setFillColor(1, 1, 1)
vocabPos:setFillColor(1, 1, 1)

image = display.newImage("res/apple.png")
image:translate(cx, 220)
image:addEventListener("touch", imageTouch)

loadImageVocab()
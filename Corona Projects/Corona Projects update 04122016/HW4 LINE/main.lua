local widget = require("widget")
local JSON = require("json")
local txtFill, buttonok
local token = "b9nDzhnBaffQOo7d7HWnzEpwAOmCTSqRjbQqYDOcyOJ"
local cx,cy
cx = display.contentCenterX
cy = display.contentCenterY

local stickerName = {"brown-cony","brown-special-edition","cony-special","eyecity-c397-lucky-star","la-dieta-especial-de-moon",
                     "line-sticker-special-edition","moon-james","moon-mad-angry-edition","moon-salaryman-special","moon-special-edition"}
local stickerIdx = 0
local initSticker

local bigSticker
--scrolling properties
local msgSticker = {}
local msgText = {}
msgCount = 1
stickerCount = 1
initMsgX = cx*2 - 50
initMsgY = cy*2 - 50
--

display.setDefault("background",0.3,0.4,0.5)

function sendNotifyListener(event)
    local status
    if(event.phase == "ended")then
        print(event.response)
        status = JSON.decode(event.response)["status"]
        print(status)
    end
end

function reqSendNotify(message)
    local params = {}
    local headers = {}
    headers["Authorization"]= "Bearer ".. token
    headers["Cache-Control"]= "no-cache "
    headers["Content-Length"]= string.len(message)
    headers["Content-Type"]= "application/x-www-form-urlencoded; charset=UTF-8"
    headers["Host"]= "notify-api.line.me"
    headers["User-Agent"]= "Line-BOT"
    params.headers = headers
    --params.body = "message=hi&imageThumbnail=http://cs.pkru.ac.th/app/flag/150.png&imageFullsize=http://cs.pkru.ac.th/app/flag/150.png"
    if(stickerIdx == 0) then
        params.body = "message="..message
    else
        params.body = "message="..message.."&imageThumbnail=https://n9neo.files.wordpress.com/2013/08/" .. stickerName[stickerIdx] .. ".png&imageFullsize=https://n9neo.files.wordpress.com/2013/08/".. stickerName[stickerIdx] ..".png"
    end        
    network.request(
        "https://notify-api.line.me/api/notify",
        "POST",
        sendNotifyListener,
        params
    )

    --after message is send, set stickerIdx and txtFill as default
    txtFill.text = ""        
    stickerIdx = 0
end

function scrollMsgUp( )    
    for i=1, 10 do            
        if(msgText[i]) then
            if(i == msgCount) then                        
                transition.to(msgText[i], {time = 300, y = msgText[i].y - 20})
            else                        
                transition.to(msgText[i], {time = 300, y = msgText[i].y - 70})
            end
            if(msgText[i].y <= cy) then msgText[i]:removeSelf(); msgText[i] = nil end                    
        end                   
    end           
end

function scrollStickerrUp( )                        
    for i=1, 10 do            
        if(msgSticker[i]) then
            if(i == stickerCount) then                        
                transition.to(msgSticker[i], {time = 300, y = msgSticker[i].y - 20})
            else                        
                transition.to(msgSticker[i], {time = 300, y = msgSticker[i].y - 70})
            end
            if(msgSticker[i].y <= cy) then msgSticker[i]:removeSelf(); msgSticker[i] = nil end                    
        end                   
    end           
end

--send message
function buttonEvent(event)
    if(event.phase == "ended") then
        if (txtFill.text ~="") then                      
            msgText[msgCount] = display.newText(txtFill.text ,initMsgX, initMsgY, "Arial" , 30)                   

            scrollMsgUp()                    
            scrollStickerrUp()

            msgCount = msgCount + 1
            if(msgCount==10) then msgCount = 1 end
            reqSendNotify(txtFill.text)                                        
        end                
    end
end

okButton = display.newImage("button.png", cx*2 - 26, cy * 2 + 18)
okButton:addEventListener("touch", buttonEvent)
txtFill = native.newTextField( cx-2, cy * 2 + 20, 220, 50)

local tableView

--send sticker
local function updateBigSticker(num)
    stickerIdx = num       
    msgSticker[stickerCount] = display.newImage("/sticker/" .. stickerName[num] .. ".png", initMsgX, initMsgY)
    msgSticker[stickerCount]:scale(2,2)    

    scrollStickerrUp()
    scrollMsgUp()     
    
    stickerCount = stickerCount + 1
    if(stickerCount==10) then stickerCount = 1 end

    reqSendNotify(" ")
end

local function rowTouch(event)
    if(event.phase == "release") then
        tableView.isVisible = false
        updateBigSticker(event.row.index)
    end
end

local function rowRender(event)    
    local id = event.row.index
    display.newImage(
        event.row,
        "/sticker/" .. stickerName[id] .. ".png",
        event.row.contentWidth / 2,
        40
    )
end

tableView = widget.newTableView
    {
        left = 5,--10,
        top = 130,--100,
        height = 340, --340,
        width = 200, --width = 100,
        onRowRender = rowRender,
        onRowTouch = rowTouch
    }

for i = 1, #stickerName do
    tableView:insertRow(
    {
        isCategory = false,
        rowHeight = 85,
        rowColor = {default = {1, 1, 1}, over = {1, 1, 1} },
        lineColor = {1, 1, 1}
    }
)
end

function showTableView( event )
    if( event.phase == "ended") then
        tableView.isVisible = not tableView.isVisible
    end
end

tableView.isVisible = false
initSticker = display.newImage("/sticker/"..stickerName[1]..".png",25, cy * 2 + 20)
initSticker:addEventListener("touch", showTableView)
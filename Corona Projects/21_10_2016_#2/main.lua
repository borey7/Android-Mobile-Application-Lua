--https://notify-bot.line.me/en/

local widget  = require("widget")
local tableView
local smallSticker, bigSticker
local i, cx, cy

local function numToFileName( num )
	return string.format("%03d", num) .. ".png"
end

local function updateBigSticker( num )
	if( bigSticker) then
		bigSticker:removeSelf()
		bigSticker = nil
	end
	bigSticker = display.newImage("/big/"..numToFileName( num ), cx+55, 180)
end

local function rowTouch( event )
	if(event.phase == "release") then
		updateBigSticker(event.row.index)
	end
end

local function rowRender( event )
	display.newImage(event.row, "/small/"..numToFileName(event.row.index), event.row.contentWidth/2, 40)
end
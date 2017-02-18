--http://www.phuketsmartcity.com/images/newtableview-image.zip
--[[
	local widget = require("widget")
	local tableView

	--example num = 1 return 001.png back
	local function numToFileName( num ) 
		return string.format("%03d", num) ..".png" --000 001 020 100
	end

	local function updateBigSticker( num )
		display.newImage("/big/"..numToFileName(num), 150, 180)
	end

	local function onRowTouch( event )
		if (event.phase == "release") then
			updateBigSticker( event.row.index )
		end
	end

	local function onRowRender( event )
		local id = event.row.index
		display.newImage(
			event.row,
			"/small/"..numToFileName( id ),
			event.row.contentWidth / 2,
			40
		)
	end

	tableView = widget.newTableView
	{
		left = 20,
		top = 100,
		height = 340,
		width = 100,
		onRowRender = onRender,
		onRowTouch = onRowTouch	
	}

	for i=1, 10 do
		tableView:insertRow(
		{
			isCategory = false,
			rowHeight = 85,
			rowColor = {default = {1,1,1}, over={1,1,1}},
			lineColor = {1,1,1}
		})
	end
]]----------------------------------------------------

local widget = require("widget")
local tableView

display.setDefault("background", 1, 1, 1)

local function numToFileName(num)
    return string.format("%03d", num) .. ".png"
end

local function updateBigSticker(num)
    display.newImage("/big/" .. numToFileName(num), 150, 180)
end

local function rowTouch(event)
    if(event.phase == "release") then
        updateBigSticker(event.row.index)
    end
end

local function rowRender(event)
    local id = event.row.index
    display.newImage(
        event.row,
        "/small/" .. numToFileName(id),
        event.row.contentWidth / 2,
        40
    )
end

tableView = widget.newTableView
    {
        left = 20,
        top = 100,
        height = 340,
        width = 100,
        onRowRender = rowRender,
        onRowTouch = rowTouch
    }

for i = 1, 10 do
    tableView:insertRow(
    {
        isCategory = false,
        rowHeight = 85,
        rowColor = {default = {1, 1, 1}, over = {1, 1, 1} },
        lineColor = {1, 1, 1}
    }
)
end
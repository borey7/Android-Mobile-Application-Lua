local widget = require("widget")
local sqlite = require("sqlite3")
local path, db, tableView
local id, name, amt, sodium

local function rowTouch(event)
	local row = event.row
	if(event.phase == "release") then
     	print(row.index)		
	end
end

local function rwoRender(event)
	local row, rowHeight, rowWidth, rowTitle1, rowTitle2, fontsize
	local rowString1, rowString2

	row = event.row
	fontsize = 20
	rowHeight =  row.contentHeight
	rowWidth = row.contentWidth

	if(row.index==1)then
		rowTitle1 = display.newText(row, "ตารางโซเดียม(mg)", 0, 0, "Quark-Bold.otf", fontsize + 15)
		rowTitle1:setFillColor(0)
		rowTitle1.x = display.contentCenterX
		rowTitle1.y = rowHeight * 0.5
		return
	end

	rowString1 = string.format("%3d.", id[row.index]).." "..name[row.index].."("..amt[row.index]..")"
	rowString2 = string.format("%3d", sodium[row.index])

	rowTitle1 = display.newText(row, rowString1, 0, 0, "Quark-Bold.otf", fontsize)
	rowTitle1:setFillColor(0)
	rowTitle1.anchorX = 0
	rowTitle1.x = 10
	rowTitle1.y = rowHeight * 0.5

	myRectangle = display.newRec(row, rowWidth-85, rowHeight * 0.47, 84, 39)
	myRectangle.strokeWidth = 1
	myRectangle:setFillColor(0.1,0.1,0.1)
	myRectangle:setStrokeColor(0.5,0.5,0.5)
	myRectangle.alpha = 1
	myRectangle.anchorX = 0

	rowTitle2 = display.newText(row, rowString2, 0,0, "Quark-Bold.otf", fontsize+10)
	rowTitle2:setFillColor(0)
	rowTitle2.anchorX = 1
	rowTitle2.x = rowWidth - 5
	rowTitle2.y = rowHeight * 0.55
end

local function onSystemEvent( )
	if(event.type == "applicationExit")then
		db:close()
	end	
end

path = system.pathForFile("food.db", system.ResourceDirectory)
db = sqlite.open(path)

display.setDefault("background",0.5,0.5,0.5)
display.setStatusBar(display.HiddenStatusBar)

tableView = widget.newTableView{
	left = 0,
	top = 0,
	height = display.contentHeight,
	width = display.contentWidth,
	onRowRender = rowRender,
	onRowRender = rowTouch
}

id = {""}
name = {""}
amt = {""}
sodium = {""}

tableView:insertRow(
	{
		isCategory = true, rowHeight = 60,
		rowColor = {default = {0.5,0.5,0.5,0.95}}
	}
)

c = 0
for row in db:nrows("SELECT * FROM food ORDER BY name;") do
	c = c + 1
	table.insert(id, c)
	table.insert(name, row.name)
	table.insert(amt, row.amt)
	table.insert(sodium, row.sodium)
	tableView:insertRow(
		{	
			inCategory = false, rowHeight = 40,
			rowColor = {default = {1,1,1}, over = {1,0.7,0.5}},
		}
	)
end
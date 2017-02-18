local widget = require("widget")
local composer = require("composer")
local sqlite = require("sqlite3")
local path, db, tableView
local id, name, amt, sodium
local view, words
local scene = composer.newScene()


local function screenTouched(event)
	local phase = event.phase
	local xStart = event.xStart
	local xEnd = event.x
	local swipeLength = math.abs(xEnd - xStart) 
	print("screen touch")
	if (phase == "began") then
		return true
	elseif (phase == "ended" or phase == "cancelled") then
		if (xStart > xEnd and swipeLength > 50) then 
			composer.gotoScene("scene3")
		elseif (xStart < xEnd and swipeLength > 50) then 
			composer.gotoScene("scene1")
		end 
	end	
end

function scene:create(event)
	local sceneGroup = self.view
end

local function categoryListener(event)
    print(event.x)
    if (event.phase == "ended") then
        view = view % 3 + 1
        createTableView()
    end
end

local function rowTouch(event)    
    if (event.phase == "swipeLeft") then
		composer.gotoScene("scene3")
    elseif (event.phase == "swipeRight") then
		composer.gotoScene("scene1")
    end
end

local function rowRender(event)
    local row, rowHeight, rowWidth, rowTitle1, rowTitle2, fontSize
    local rowString1, rowString2

    row = event.row
    fontSize = 20
    rowHeight = row.contentHeight
    rowWidth = row.contentWidth

    if (row.index == 1) then
        rowTitle1 = display.newText(row, "ปริมาณโซเดียม (มก.)", 0, 0, "Quark-Bold", fontSize + 15)    
        rowTitle1:setFillColor(1, 1, 1)
        rowTitle1.x = display.contentCenterX
        rowTitle1.y = rowHeight * 0.5
        rowTitle1:addEventListener("touch", categoryListener)
        return
    end

    rowString1 = string.format("%3d.", id[row.index]) .. " " .. name[row.index] .. " (" .. amt[row.index] .. ")"
    rowString2 = string.format("%3d", sodium[row.index])

    rowTitle1 = display.newText(row,rowString1, 0, 0, "Quark-Bold.otf", fontSize)    
    rowTitle1:setFillColor(0)
    rowTitle1.anchorX = 0
    rowTitle1.x = 10
    rowTitle1.y = rowHeight * 0.5

    myRectangle = display.newRect(row, rowWidth - 85, rowHeight * 0.47, 84, 39)
    myRectangle.strokeWidth = 1
    myRectangle:setFillColor(0.1, 0.1, 0.1)
    myRectangle:setStrokeColor(0.5, 0.5, 0.5)
    myRectangle.alpha = 1
    myRectangle.anchorX = 0

    rowTitle2 = display.newText(row,rowString2, 0, 0, "Quark-Bold.otf", fontSize + 10)
    rowTitle2:setFillColor(1,0.5,0)
    rowTitle2.anchorX = 1
    rowTitle2.x = rowWidth - 5
    rowTitle2.y = rowHeight * 0.55

end


function createTableView(filter)
    local sqlCommand, sqlFilter, nameNoWB

    tableView:deleteAllRows()

    id = {0}
    name = {""}
    namewb = {""}
    amt = {""}
    sodium = {0}

    tableView:insertRow(
        {
            isCategory = true, rowHeight = 60,
            rowColor = {default = {77 / 255, 86 / 255, 86 / 255}}
        }
    )

    sqlFilter = ""
    if not (filter == nil) then
        sqlFilter = "WHERE name LIKE \"%" .. filter .. "%\""
    end

    if (view == 1) then
        sqlCommand = "SELECT * FROM sodium " .. sqlFilter .. " ORDER BY name;"
    elseif (view == 2) then
        sqlCommand = "SELECT * FROM sodium " .. sqlFilter .. " ORDER BY sodium;"
    else
        sqlCommand = "SELECT * FROM sodium " .. sqlFilter .. " ORDER BY sodium DESC;"
    end
    print(sqlCommand)
    
    c = 0
    for row in db:nrows(sqlCommand) do
        c = c + 1
        table.insert(id, c)
        nameSpace = string.gsub(row.name, "|", " ")
        nameNoWB = string.gsub(row.name, "|", "")
        table.insert(name, nameNoWB)
        table.insert(namewb, nameSpace)
        table.insert(amt, row.amt)
        table.insert(sodium, row.sodium)
        tableView:insertRow(
            {
                isCategory = false, rowHeight = 40,
                rowColor = {default = {1, 1, 1}, over = {1, 0.7, 0.5}},
            }
        )
    end
end

function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then

		path = system.pathForFile("food.db", system.ResourceDirectory)
		db = sqlite.open(path)

		display.setDefault("background", 0.5, 0.5, 0.5)
		display.setStatusBar(display.HiddenStatusBar)

		tableView = widget.newTableView {
		    left = 0, top = 0,
		    height = display.contentHeight,
		    width = display.contentWidth,
		    onRowRender = rowRender,
		    onRowTouch = rowTouch
		}

		view = 1
		sceneGroup:insert(tableView)
		createTableView()

	elseif (phase == "did") then
		Runtime:addEventListener("touch", screenTouched)
	end
end

function scene:hide(event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then
		tableView:removeSelf()
		tableView = nil
		Runtime:removeEventListener("touch", screenTouched)
		db:close()
	elseif (phase == "did") then
	end
end

function scene:destroy(event)
	local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene
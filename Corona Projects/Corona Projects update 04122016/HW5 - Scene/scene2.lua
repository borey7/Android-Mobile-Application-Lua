local widget = require("widget")
local composer = require("composer")
local sqlite = require("sqlite3")
local path, db, tableView
local id, name, code, credit, year_sem, typename, No, detail
local view, words
local scene = composer.newScene()

view = 1
 
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
			scene1Click = false
			composer.gotoScene("scene3",{effect = "fade", time = 200})
		elseif (xStart < xEnd and swipeLength > 50) then 
			scene1Click = false
			composer.gotoScene("scene1", {effect = "fade", time = 200})
		end 
	end	
end

function scene:create(event)
	local sceneGroup = self.view
end

local function categoryListener(event)
    print(event.x)
    if (event.phase == "ended") then
        view = view % 2 + 1
        createTableView()
    end
end

local function rowTouch(event)        

    if (event.phase == "swipeLeft") then
    	scene1Click = false        
		composer.gotoScene("scene3", {effect = "fade", time = 200})		
    elseif (event.phase == "swipeRight") then
    	scene1Click = false
		composer.gotoScene("scene1", {effect = "fade", time = 200})
    elseif(event.phase == "release") then
        local idx = event.target.index        
        local alert = native.showAlert( code[idx], 
                                        "Code  : "..code[idx].."\n"..
                                        "Name  : "..name[idx].."\n"..                                        
                                        "Category   : "..typename[idx].."\n"..
                                        "Credit     : "..credit[idx].."\n"..
                                        "Year       : "..string.sub(year_sem[idx],1,1).."\n"..
                                        "Semester   : "..string.sub(year_sem[idx],2,2).."\n"..
                                        "Detail     : "..detail[idx], 
                                        { "OK"})   
                                    
    end    
end

--------------------------------------

--show data
local function rowRender(event)
    local row, rowHeight, rowWidth, rowTitle1, rowTitle2, fontSize
    local rowString1, rowString2

    row = event.row
    fontSize = 20
    rowHeight = row.contentHeight
    rowWidth = row.contentWidth

    if (row.index == 1) then
        rowTitle1 = display.newText(row, "ชื่อรายวิชา", 0, 0, "Quark-Bold", fontSize + 15)    
        rowTitle1:setFillColor(1, 1, 1)
        rowTitle1.x = display.contentCenterX
        rowTitle1.y = rowHeight * 0.5
        rowTitle1:addEventListener("touch", categoryListener)
        return
    end

    if(view==1) then rowString1 = string.format("%2d.", No[row.index]) .. "(" .. code[row.index] .. ")" .. name[row.index] --sort by year_sem
    elseif(view==2) then rowString1 = string.format("%2d.", No[row.index]) .. "(" .. typename[row.index] .. ")" .. name[row.index] --sort by category
    else
    	rowString1 = string.format("%2d.", No[row.index]) .. "(" .. code[row.index] .. ")" .. name[row.index] --sort by year_sem
    end
    rowString2 = year_sem[row.index].."("..credit[row.index]..")"

    rowTitle1 = display.newText(row,rowString1, 0, 0, "Quark-Bold.otf", fontSize)    
    rowTitle1:setFillColor(0)
    rowTitle1.anchorX = 0
    rowTitle1.x = 10
    rowTitle1.y = rowHeight * 0.5

    myRectangle = display.newRect(row, rowWidth - 85, rowHeight * 0.47, 84, 39)
    myRectangle.strokeWidth = 1
    myRectangle:setFillColor(0.3, 0.3, 0.5)
    myRectangle:setStrokeColor(0.5, 0.5, 0.5)
    myRectangle.alpha = 1
    myRectangle.anchorX = 0

    rowTitle2 = display.newText(row,rowString2, 0, 0, "Quark-Bold.otf", fontSize + 10)
    rowTitle2:setFillColor(1,0.5,0)
    rowTitle2.anchorX = 1
    rowTitle2.x = rowWidth - 5
    rowTitle2.y = rowHeight * 0.55

end

--retrieve data from db
function createTableView(filter)
    local sqlCommand, sqlFilter, nameNoWB

    tableView:deleteAllRows()

    No = {0}
    id = {0}
    name = {""}
    namewb = {""}
    code = {""}
    credit = {0}
    year_sem = {0}
   	typename = {""}
    detail = {""}

    tableView:insertRow(
        {
            isCategory = true, rowHeight = 60,
            rowColor = {default = {0.3, 0.4, 0.5}}
        }
    )

    sqlFilter = ""       
    if not (filter == nil) then    
        sqlFilter = "WHERE year_sem LIKE \"%" .. filter .. "%\""
    end

    if scene1Click then
        sqlFilter = "WHERE year_sem LIKE \"" .. subjbysem .. "\""        
    end

    if (view == 1) then
        sqlCommand = "SELECT * FROM subject INNER JOIN type ON subject.typeid = type.typeid " .. sqlFilter .. " ORDER BY year_sem;"
    elseif (view == 2) then
        sqlCommand = "SELECT * FROM subject INNER JOIN type ON subject.typeid = type.typeid " .. sqlFilter .. " ORDER BY type.typename;" -- by catagory
    else
        sqlCommand = "SELECT * FROM subject INNER JOIN type ON subject.typeid = type.typeid " .. sqlFilter .. " ORDER BY year_sem;"
    end
    print(sqlCommand)
    
    c = 0
    for row in db:nrows(sqlCommand) do
        c = c + 1
        table.insert(No, c)
        table.insert(id, row.subjid)
        nameSpace = string.gsub(row.subjname, "|", " ")
        nameNoWB = string.gsub(row.subjname, "|", "")
        table.insert(name, nameNoWB)
        table.insert(namewb, nameSpace)
        table.insert(code, row.code)
        table.insert(credit, row.credit)
        table.insert(year_sem, row.year_sem)
        table.insert(typename, row.typename)
        table.insert(detail, row.subjdetail)
        tableView:insertRow(
            {
                isCategory = false, rowHeight = 40,
                rowColor = {default = {1, 1, 1}, over = {1, 0.7, 0.5}},
            }
        )
    end
end

--connect db
function scene:show(event)
	local sceneGroup = self.view
	local phase = event.phase
	if (phase == "will") then

		path = system.pathForFile("ITcurriculum.db", system.ResourceDirectory)
		db = sqlite.open(path)

		display.setDefault("background", 0.3, 0.4, 0.5)
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

--------------------------------------

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
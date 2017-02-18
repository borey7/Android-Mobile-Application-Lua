local sqlite = require("sqlite3")
local path, db, staff, sql, i, row

--------------------------------------------------------------
display.setDefault("background",0,0.6,1)

path = system.pathForFile("data.db", system.DocumentsDirectory)
db = sqlite.open(path)

db:exec("DROP TABLE personel;")
db:exec([[
	CREATE TABLE personel (
		id INTEGER PRIMARY KEY AUTOINCREMENT,
		fname TEXT,
		lname TEXT,
		gender INTEGER,
		position TEXT,
		salary NUMERIC,
		tel TEXT
	);
]])

staff = 
{
	{
		fname = "Somying",
		lname = "Jairai",
		gender = 2,
		position = "Officer",
		salary = 25000,
		tel = "0894479256"
	},
	{
		fname = "Somchai",
		lname = "Jaidee",
		gender = 1,
		position = "Security",
		salary = 18000,
		tel = "0817944631"
	},
	{
		fname = "Somsri",
		lname = "Jaisad",
		gender = 2,
		position = "Manager",
		salary = 45000,
		tel = "0841123456"
	},
	{
		fname = "Somrat",
		lname = "Jaiwoon",
		gender = 1,
		position = "Officer",
		salary = 22000,
		tel = "0857741395"
	},
	{
		fname = "Somboon",
		lname = "Jaiplod",
		gender = 1,
		position = "Security",
		salary = 17500,
		tel = "0861124578"
	},
	{
		fname = "Somyot",
		lname = "Jairak",
		gender = 1,
		position = "Messenger",
		salary = 22000,
		tel = "0945123789"
	}
}
 
for i = 1, #staff do
	local fname, lname, gender, position, salary, tel
	fname = staff[i].fname
	lname = staff[i].lname
	gender = staff[i].gender
	position = staff[i].position
	salary = staff[i].salary
	tel = staff[i].tel
	sql = "INSERT INTO personel VALUES (" ..
			"NULL,'" .. 
			fname .. "','" ..
			lname .. "','" ..
			gender .. "','" ..
			position .. "'," ..
			salary .. ",'" ..
			tel ..	"');"
	db:exec(sql)
end

print(string.rep("-", 60))
for row in db:nrows("SELECT * FROM personel;") do
	print(
		row.id .. " - " .. 
		row.fname .. " - " .. 
		row.lname .. " - " .. 
		row.gender .. " - " .. 
		row.position .. " - " .. 
		row.salary .. " - " .. 
		row.tel
	)
end
print(string.rep("-", 60))

--------------------------------------------------
local widget = require("widget")
local txfFname, txfLname, txfGender, txfPosition, txfSalary, txfTel
local titleFname, titleLname, titleGender, titlePosition, titleSalary, titleTel, title
local regBtn
local proTimer, imageProcess
local bg
local meesageAlert
local regStatusBtn
i = -10
firstRun = true
cx = display.contentCenterX; cy = display.contentCenterY

bg = display.newImage("bg.jpg")
regStatusBtn = display.newImage("home.png")
regStatusBtn.x = cx
regStatusBtn.y = cy + 250
regStatusBtn:scale(0.5,0.5)
regStatusBtn.id = "regStatus"
regStatusBtn.isVisible = false

title = display.newText("Reistration Form", cx, cy - 200, "Arrial", 30)
titleFname = display.newText("First name ", cx - 80, cy - 150, "Arial", 20)
txfFname = native.newTextField(cx + 65, titleFname.y , 170 , 30)
titleLname = display.newText("Last name ", cx - 80, cy - 100, "Arial", 20)
txfLname = native.newTextField(cx + 65, titleLname.y , 170 , 30)
titleGender = display.newText("Gender ", cx - 80, cy - 50, "Arial", 20)
txfGender = native.newTextField(cx + 65, titleGender.y , 170 , 30)
titlePosition = display.newText("Position ", cx - 80, cy, "Arial", 20)
txfPosition = native.newTextField(cx + 65, titlePosition.y , 170 , 30)
titleSalary = display.newText("Salary ", cx - 80, cy + 50, "Arial", 20)
txfSalary = native.newTextField(cx + 65, titleSalary.y , 170 , 30)
titleTel = display.newText("Tel ", cx - 80, cy + 100, "Arial", 20)
txfTel = native.newTextField(cx + 65, titleTel.y , 170 , 30)

--------------------------------------------------
--condition form
local function formIsRight()    
    if( string.len(txfFname.text) <= 0 or
    	string.len(txfLname.text) <= 0 or
    	string.len(txfGender.text) <= 0 or
    	string.len(txfPosition.text) <= 0 or
    	string.len(txfSalary.text) <= 0 or
    	string.len(txfTel.text) <= 0 ) then
    	print("form is not available")
        return false
    end
    print("form is available")
    return true
end
txfGender.inputType = "number"
txfSalary.inputType = "number"
txfTel.inputType = "number"
--------------------------------------------------

local homeGroup = display.newGroup()
homeGroup:insert(title)
homeGroup:insert(titleFname)
homeGroup:insert(titleLname)
homeGroup:insert(titleGender)
homeGroup:insert(titlePosition)
homeGroup:insert(titleSalary)
homeGroup:insert(titleTel)

local function homePage(state)	
	txfFname.isVisible = state
	txfLname.isVisible = state
	txfGender.isVisible = state
	txfPosition.isVisible = state
	txfSalary.isVisible = state
	txfTel.isVisible = state
	homeGroup.isVisible = state
	regBtn.isVisible = state
end

local function showMessage()
	if(meesageAlert) then meesageAlert:removeSelf(); meesageAlert = nil end
	meesageAlert = display.newText("Successful!", cx, cy + 110, "Arial", 30)
	transition.to(meesageAlert, {time = 500, y = cy + 90})
end

local function loadImageProcess()	
	if not (i==-10) or firstRun then 
		if(imageProcess)then imageProcess:removeSelf(); imageProcess = nil end
	end
	firstRun = false
	imageProcess = display.newImage("process/"..i..".png",cx,cy)
	imageProcess:scale(0.5,0.5)	
	i = i + 1
	if(i == 46) then showMessage() end
	if(i > 52) then		
		--if(imageProcess)then imageProcess:removeSelf(); imageProce = nil end
		if(proTimer)then timer.cancel(proTimer); proTimer=nil end		
		regStatusBtn.isVisible = true
	end	
end

local function processLoad()
	i = -10
	if(proTimer)then timer.cancel(proTimer); proTimer=nil end
	proTimer = timer.performWithDelay(40, loadImageProcess, 0)
end

local function statusPage(state)
	regStatusBtn.isVisible = state
	if(proTimer)then timer.cancel(proTimer); proTimer=nil end	
	if(imageProcess)then imageProcess:removeSelf(); imageProce = nil end
	if(meesageAlert) then meesageAlert:removeSelf(); meesageAlert = nil end
end

local function changePage(event)
	local idBtn = event.target.id
	if(event.phase=="ended") then
		if(idBtn=="regStatus")then
			statusPage(false)
			homePage(true)	
		-- elseif(idBtn=="regBtn")then
		-- 	homePage(false)
		-- 	processLoad()
		end
	end
end

local function registerButtonClick(event)
	if(event.phase == "ended") then		
		if(meesageAlert) then meesageAlert:removeSelf(); meesageAlert = nil end
		if(formIsRight()) then
		--------------------------------------------------------
			--insert data
			fname = txfFname.text
			lname = txfLname.text
			gender = tonumber(txfGender.text)
			position = txfPosition.text
			salary = tonumber(txfSalary.text)
			tel = txfTel.text
			sql = "INSERT INTO personel VALUES (" ..
				"NULL,'" .. 
				fname .. "','" ..
				lname .. "','" ..
				gender .. "','" ..
				position .. "'," ..
				salary .. ",'" ..
				tel ..	"');"
			db:exec(sql)
		--------------------------------------------------------	
			--changePage()		
			homePage(false)
		 	processLoad()
		
		else			
			meesageAlert = display.newText("Your information is not available!", cx, cy + 240, "Arial", 20)
			meesageAlert:setFillColor(1,0,0)			
		end
		if(regStatusBtn)then			
			regStatusBtn:addEventListener("touch", changePage)
		end
	end
end

regBtn = widget.newButton(
    {
        x = cx,
        y = cy + 180,
        width = 150,
        height =40,
        id = "regBtn",
        label = "Register",
        onEvent = registerButtonClick,
        shape = "Rect",
        labelColor = {default={1,1,1}, over={0,0,0,0.5}},        
        fillColor = {default={0.4,0.4,0.4}, over={0.8,0.8,0.8}}            
    }
)
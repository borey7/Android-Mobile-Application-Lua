--Yandex : russia search engine? translate language

local  JSON = require("json")
local person, encoded, key
local path, file, contents

path = system.pathForFile("person.json", system.ResourceDirectory)
file = io.open(path, "r") --open file
if (file) then
	contents = file:read("*a") --*a = all
	io.close(file)
end
person = JSON.decode(contents) --json to table
print(person["fname"])

for key in pairs(person) do
	print(key , " = ", person[key])
end

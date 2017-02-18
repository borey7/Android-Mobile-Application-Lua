local  JSON = require("json")
local  person, encoded

person = {
	["fname"] = "Jonathan",
	["lname"] = "Kuanniang",
	["dept"] = "001",
	["salary"] = 15000,
	["bio"] = {"B", 75, 168, "left"}
}

encoded = JSON.encode(person)
print(encoded)

encoded = JSON.encode(person, {indent = true}) --indent = true only easy looking
print(encoded)
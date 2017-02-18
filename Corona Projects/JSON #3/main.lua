local JSON = require("json")
local translate, encoded, key

local function loadJSON2TABLE(filename)
    local path, file, contents
    path = system.pathForFile(filename, system.DocumentsDirectory)
    file = io.open(path, "r")
    if (file) then
        contents = file:read("*a")
        io.close(file)
        return contents
    end
    return nil
end
local function networkListener(event)
    if(event.isError) then
        print("Download failed...")
        elseif (event.phase == "ended") then
        print("Saved " .. event.response.filename)
        translate = JSON.decode(loadJSON2TABLE("translate.json"))
        print(translate["text"][1])
    end
end

network.download(
    "https://translate.yandex.net/api/v1.5/tr.json/translate?key=trnsl.1.1.20160927T113237Z.f287a7e1869b8e4d.b13690fd5eaba0612cc507026153cf3971a3b454&text=hello&lang=en-th",
    "GET",
    networkListener,
    {},
    "translate.json",
    system.DocumentsDirectory
)
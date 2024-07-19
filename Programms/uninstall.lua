local url = "installList.txt"
local fs = fs;

local file = fs.open(url, "r")
local content = file.readAll()
file.close()

local function trimSlash(str)
    local result = string.match(str, "(.+)/")
    if result then
        return trimSlash(result)
    else
        return str
    end
end

for line in string.gmatch(content, "([^\r\n]+)") do
    local result1 = trimSlash(line)
    if fs.exists(result1) then
        print("deleting " .. result1)
        fs.delete(result1)
    end
end

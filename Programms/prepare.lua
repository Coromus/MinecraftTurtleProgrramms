local fs = fs;

local data = {}
local index = 0
local path = ""

local function concat(a, b)
    if a == "" then
        return b
    end

    return a .. "/" .. b
end

local function recursive(path)
    local localPath = path
    for _, file in ipairs(fs.list(localPath)) do
        if file ~= "rom" then
            local normalPath = concat(localPath, file)
            if fs.isDir(normalPath) == false then
                print(normalPath)
                data[index] = normalPath;
                index = index + 1
                --sleep(0.2)
            else
                if fs.exists(normalPath) then
                    recursive(normalPath)
                end
            end
        end
    end
end

recursive(path)

local url = "installList.txt"
if fs.exists(url) then
    print("exist, rewriting")
    fs.delete(url)
end
local file = fs.open(url, "w")

for index, value in pairs(data) do
    file.write(data[index].."\r\n")
end

file.close()

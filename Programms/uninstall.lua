local url = "installList.txt"

local file = fs.open(url, "r")
local content = file.readAll()
file.close()

for line in string.gmatch(content, "([^\r\n]+)") do
  fs.delete(line)
end
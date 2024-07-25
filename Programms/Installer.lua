local http = http;
local term = term;

local function question(Question, Answers)
  print(Question)
  local result = nil
  while result == nil do
    local chr = table.pack(os.pullEvent("char"))
    for i, v in pairs(Answers) do
      if v == string.upper(chr[2]) then result = v end
    end
  end
  return result
end

local function download(repo, url)
  -- term.clear()
  -- term.setCursorPos(0, 0)
  print("downloading " .. url)

  local downloaded = http.get(repo .. url)
  if downloaded == nil then
    print("error in " .. url)
    return
  end
  local data = downloaded.readAll()

  if fs.exists(url) then
    print("exist, rewriting")
    fs.delete(url)
  end

  local file = fs.open(url, "w")
  file.write(data)
  file.close()
end

local downloadQuestion = question("Do you want to download turtle programms (Y/N)", { "Y", "N" })
if downloadQuestion == "Y" then
  print("Downloading files...")
  local repo = "https://raw.githubusercontent.com/Coromus/MinecraftTurtleProgrramms/main/Programms/"
  local url = "installList.txt"
  download(repo, url)

  local file = fs.open(url, "r")
  local content = file.readAll()
  file.close()

  for line in string.gmatch(content, "([^\r\n]+)") do
    download(repo, line)
  end


  print("Done Installing files! ")
  print("Now rebooting in 3 seconds...")
  sleep(3)
  os.reboot()
end

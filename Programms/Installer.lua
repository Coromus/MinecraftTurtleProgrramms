local function Question(Question, Answers)
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
  local download = Question("Do you want to download PhileOS BETA 0.1.1? (Y/N)", {"Y", "N"})
  if download == "Y" then
    print("Downloading OS files...")
    local OSLOCATION = "nNLSgkpW"
    shell.run("pastebin", "get", OSLOCATION, "/installerFiles")
    local fil = fs.open("/installerFiles", "r")
    local files = textutils.unserialize(fil.readAll())
    fil.close()
    print("Installing OS files...")
    for i, v in pairs(files) do
      local handler = fs.open(v[1], "w")
      handler.write(v[2])
      handler.close()
      print("Installed "..v[1].. " ("..i.."/"..#files..")")
    end
    --fs.delete("/installerFiles")
    print("Done Installing OS! ")

    print("Now rebooting in 3 seconds...")
    sleep(3)
    os.reboot()
  end
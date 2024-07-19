local MovingScript = require("Classes.Mover")
local Moving = MovingScript.new(false)
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
local term = term;
local keys = keys;
local turtle = turtle;
local colours = colours;
local fs = fs;

local standartColorList = {
    [" 255 255 255"] = 1,
    [" 242 178 51"] = 2,
    [" 229 127 216"] = 4,
    [" 153 178 242"] = 8,
    [" 222 222 108"] = 16,
    [" 127 204 25"] = 32,
    [" 242 178 204"] = 64,
    [" 76 76 76"] = 128,
    [" 153 153 153"] = 256,
    [" 76 153 178"] = 512,
    [" 178 102 229"] = 1024,
    [" 51 102 204"] = 2048,
    [" 127 102 76"] = 4096,
    [" 87 166 78"] = 8192,
    [" 204 76 76"] = 16384,
    [" 25 25 25"] = 32768
}


function GetColor(strColor)
    local localColor = standartColorList[strColor]
    if localColor == nil then
        localColor = colours.black
    end

    return localColor
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

local maxZ = 0
local minY = 999
local levelTable = {}

local colorDig = " 0 0 0"
local colorTable = {}
local colorTableRev = {}
local colorTableSize = {}
local palleteDontUse = { false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false }
local maxColors = 0

local moveCount = 0



function NextLineToArrays(line)
    CLR = 3

    moveCount = moveCount + 1
    local counter = 0
    local array = {}
    array[CLR] = ""
    for token in string.gmatch(line, "[^%s]+") do
        if counter < CLR then
            array[counter] = token
        else
            array[CLR] = array[CLR] .. " " .. tostring(token)
        end
        counter = counter + 1
    end

    array[0] = tonumber(array[0])
    array[1] = tonumber(array[1])
    array[2] = tonumber(array[2])
    if minY > array[2] then
        minY = array[2]
    end

    local xyTable = {}
    xyTable["x"] = array[1]
    xyTable["z"] = array[0]
    xyTable["color"] = array[CLR]
    xyTable["choosen"] = false
    print(xyTable[0])
    if levelTable[array[2]] == nil then
        levelTable[array[2]] = {}
        levelTable[array[2]][0] = xyTable
    else
        levelTable[array[2]][#levelTable[array[2]] + 1] = xyTable
    end


    if colorTable[array[CLR]] == nil then
        maxColors = maxColors + 1
        colorTable[array[CLR]] = maxColors
        colorTableRev[maxColors] = array[CLR]
        colorTableSize[array[CLR]] = 0
    end

    colorTableSize[array[CLR]] = colorTableSize[array[CLR]] + 1
end

function CalculateDistancePrice(x, z)
    local shiftX = Moving.x - x
    local shiftZ = Moving.z - z
    local price = math.abs(shiftX) + math.abs(shiftZ)
    if (shiftX) ~= 0 then
        price = price + 1
    end

    if (shiftZ) ~= 0 then
        price = price + 1
    end

    if Moving.look == 1 and shiftX > 0 then
        price = price + 1
    end

    if Moving.look == 3 and shiftX < 0 then
        price = price + 1
    end

    if Moving.look == 2 and shiftZ > 0 then
        price = price + 1
    end

    if Moving.look == 4 and shiftZ < 0 then
        price = price + 1
    end

    return price
end

function NearestPoint(level)
    local bestPrice = 999
    local bestPoint = nil
    if #levelTable[level] ~= nil then
        for iDot = 0, #levelTable[level] do
            if levelTable[level][iDot].choosen ~= true then
                local price = CalculateDistancePrice(levelTable[level][iDot].x, levelTable[level][iDot].z)
                if price < bestPrice then
                    bestPoint = iDot
                    bestPrice = price
                end
            end
        end
    end

    if bestPoint ~= nil then
        levelTable[level][bestPoint].choosen = true
        return bestPoint
    end

    return nil
end

local function redrawSelectFolderScreen(pathList, number)
    term.clear()
    term.setCursorPos(1, 1)
    for pathVariant, pathName in pairs(pathList) do
        if pathVariant == number then
            term.write("> ")
        else
            term.write("  ")
        end
        print(pathName)
    end
end

local function selectFolder(path)
    local pathList = fs.list(path)
    local selected = 1

    redrawSelectFolderScreen(pathList, selected)

    if #pathList > 0 then
        while true do
            local e, key = os.pullEvent("key")
            if key == keys.up then
                selected = selected - 1
                if selected < 1 then
                    selected = #pathList
                end
                redrawSelectFolderScreen(pathList, selected)
            elseif key == keys.down then
                selected = selected + 1
                if selected > #pathList then
                    selected = 1
                end
                redrawSelectFolderScreen(pathList, selected)
            elseif key == keys.enter then
                break
            end
        end
    end


    return pathList[selected]
end
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------



term.clear()
term.setCursorPos(1, 1)

local file = nil

while file == nil do
    local folderName = selectFolder("Print")
    --    file = fs.open(read() .. "/model.ply", "r")
    file = fs.open("Print/" .. folderName .. "/model.ply", "r")
end


while file.readLine() ~= "end_header" do
end


local line = file.readLine()
local i = 0

while line ~= nil do
    NextLineToArrays(line)
    line = file.readLine()
end

print("colors count: ", maxColors)

local slotsToColors = 0
local slotsToColorsCount = 0

local function drawColorBlock(termColor, txt)
    if term.isColor() then
        term.setTextColor(colours.black)
        term.setBackgroundColor(GetColor(termColor))
    end

    term.write(txt)

    if term.isColor() then
        local strLenght = string.len(txt)
        while strLenght < 13 do
            strLenght = strLenght + 1
            term.write(" ")
        end
        term.setTextColor(colours.white)
        term.setBackgroundColor(colours.black)
    end
end

for k, v in ipairs(colorTableRev) do
    --print(k," "..v.." ,count: ", colorTableSize[v])
    if v ~= colorDig then
        slotsToColors = slotsToColors + 1
        slotsToColorsCount = math.floor(colorTableSize[v] / 64)
        if (slotsToColorsCount == 0) then
            drawColorBlock(v, "slot " .. tostring(slotsToColors) .. " :")
            if not term.isColor() then
                term.write(v)
            end
            print(" - Total: ", colorTableSize[v])
        else
            drawColorBlock(v,
                "slots " .. tostring(slotsToColors) .. "-" .. tostring(slotsToColors + slotsToColorsCount) .. " :")
            if not term.isColor() then
                term.write(v)
            end
            print(" - Total: ", colorTableSize[v])
        end

        colorTable[v] = slotsToColors
        slotsToColors = slotsToColors + slotsToColorsCount
    end
end


local currentSlot = tonumber(0)
-- work with levels
print(" ")
print("Run? [Y]es, [N]o, [P]eaceful")

local flagToRun = false

while true do
    local e, key = os.pullEvent("key")
    if key == keys.y then
        flagToRun = true
        break
    elseif key == keys.p then
        flagToRun = true
        Moving.peacefulMode = true
        break
    elseif key == keys.n then
        flagToRun = false
        print("Aborted by user")
        break
    end
end




if flagToRun then
    for iLevel = minY, #levelTable do
        print(iLevel)
        Moving:moveToY(iLevel + 1)
        --        for iDot=0,#levelTable[iLevel] do
        local levelInProgress = true
        while levelInProgress do
            local iDot = NearestPoint(iLevel)

            if iDot ~= nil then
                print("color : ", tonumber(colorTable[levelTable[iLevel][iDot].color]))
                sleep(0.1)
                Moving:moveToXZ(levelTable[iLevel][iDot].x, levelTable[iLevel][iDot].z)
                if levelTable[iLevel][iDot].color ~= colorDig then
                    currentSlot = tonumber(colorTable[levelTable[iLevel][iDot].color])
                    while (turtle.getItemCount(currentSlot) == 0) or palleteDontUse[currentSlot] == true do
                        palleteDontUse[currentSlot or 0] = true
                        currentSlot = currentSlot + 1
                        if currentSlot == 17 then
                            currentSlot = 1
                            print("slots empty")
                        end
                    end
                    print("currentSlot- ", currentSlot)
                    turtle.select(currentSlot)
                    while not turtle.placeDown() do
                        if not turtle.digDown() then
                            if Moving.peacefulMode then
                                sleep(0.5)
                            else
                                turtle.attackDown()
                            end
                        end
                        sleep(0.5)
                    end
                else
                    turtle.digDown()
                end
            else
                levelInProgress = false
            end
        end
    end
end

Moving:moveToXZ(0, 0)
Moving:lookForward()
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

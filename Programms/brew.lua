-- how to use
-- Установить на поверхность черепашку (смотрит от игрока)
-- справа от неё сундук с наполненными водой бутылками
-- слева от неё пустой сундук

---@diagnostic disable: undefined-global
function UpdateCoord() -- sys --
	-- print(TurtleMove)
	if     TurtleDirection == 1 then
		TurtleX = TurtleX + TurtleMove
	elseif TurtleDirection == 2 then
		TurtleZ = TurtleZ + TurtleMove
	elseif TurtleDirection == 3 then
		TurtleX = TurtleX - TurtleMove
	elseif TurtleDirection == 4 then
		TurtleZ = TurtleZ - TurtleMove
	end	
end
function Up() -- Move Up --
        while not turtle.up() do
                if not turtle.digUp() then
                        turtle.attackUp()
                end
                sleep(0.5)
        end
     TurtleY = TurtleY + 1
end
function Down() -- Move Down --
        while not turtle.down() do
                        if not turtle.digDown() then
                                turtle.attackDown()
                        end
                        sleep(0.5)
        end
     TurtleY = TurtleY - 1
end
function Fwd() -- Move Forward --
        while not turtle.forward() do
                if not turtle.dig() then
                        turtle.attack()
                end
                sleep(0.5)
        end
	 TurtleMove = 1
	 UpdateCoord()
end
function Back() -- Move Back --
  complete = turtle.back()
  while complete ~= true do
    complete = turtle.back()
  end
	TurtleMove = -1
	UpdateCoord()
end
function Right() -- Rotate Right --
	turtle.turnRight()
	TurtleDirection = TurtleDirection + 1
	if TurtleDirection>4 then
		TurtleDirection = TurtleDirection - 4
	end
	if TurtleDirection<1 then
		TurtleDirection = TurtleDirection + 4
	end
end
function Left() -- Rotate Left --
	turtle.turnLeft()
	TurtleDirection = TurtleDirection - 1
	if TurtleDirection>4 then
		TurtleDirection = TurtleDirection - 4
	end
	if TurtleDirection<1 then
		TurtleDirection = TurtleDirection + 4
	end
end
function TrnF() -- Set rotation Forward --
	if TurtleDirection==2 then
		Left()
	elseif TurtleDirection==4 then
		Right()
	elseif TurtleDirection==3 then
		Left()
		Left()
	end
end
function TrnB() -- Set rotation Backward --
	if TurtleDirection==2 then
		Right()
	elseif TurtleDirection==4 then
		Left()
	elseif TurtleDirection==1 then
		Left()
		Left()
	end
end
function TrnL() -- Set rotation Left --
	if TurtleDirection==3 then
		Right()
	elseif TurtleDirection==1 then
		Left()
	elseif TurtleDirection==2 then
		Left()
		Left()
	end
end
function TrnR() -- Set rotation Right --
	if TurtleDirection==1 then
		Right()
	elseif TurtleDirection==3 then
		Left()
	elseif TurtleDirection==4 then
		Left()
		Left()
	end
end

function MoveTo(z,x) 
 while TurtleX<x do
 TrnF()
 Fwd()
 end

 while TurtleX>x do
 TrnB()
 Fwd()
 end

  while TurtleZ<z do
 TrnR()
 Fwd()
 end

  while TurtleZ>z do
 TrnL()
 Fwd()
 end
end







function BottlesToChest()
    turtle.select(9)
    turtle.suckUp()
    turtle.select(10)
    turtle.suckUp()
    turtle.select(11)
    turtle.suckUp()

    TrnL()

    turtle.select(9)
    turtle.drop()
    turtle.select(10)
    turtle.drop()
    turtle.select(11)
    turtle.drop()

    TrnF()

end

function Ingridient(number)
    count = turtle.getItemCount(number)
    while count == 0 do
        term.clear()
        term.setCursorPos(1, 1)
        print("Check slot ", number)
        sleep(0.5)
        count = turtle.getItemCount(number)
    end
    ShowStats()
    turtle.select(number)

    complete = turtle.dropDown(1)
    while complete ~= true do
        term.clear()
        term.setCursorPos(1, 1)
        print("Check bottles")
        sleep(0.5)
        complete = turtle.dropDown(1)
    end

    sleep(22)
end

function ShowStats()
    term.clear()
    term.setCursorPos(1, 1)
    print("Brew type = ", brewType)
    print("Cycles =  ", brewCount)
    print("Mod =  ", brewMod)
    print("Powder = ", brewPowder)
    print("currentCycle = ", currentCycle)
end

function Pulse()
    rs.setOutput("left" , true)
    sleep(0.5)
    rs.setOutput("left" , false)
    sleep(0.5)
end


---------------- global ------------------
TurtleX,TurtleY,TurtleZ= 0,0,0 -- вперёд, вправо --
TurtleDirection, TurtleMove= 1,1
---------------- global ------------------


term.clear()
term.setCursorPos(1, 1)
print("Place extra ingridient in [12]")
print("Place brew base in left down slot [13]")
print("Place redstone ang glow dust [14][15]")
print("Place powder in right down slot [16]")
print("Brew type?")
print("See in 1-8 slots")

brewType = 0
while true do
	local e,key = os.pullEvent( "key" )
	if key == keys.one then
        brewType = 1
        break
    end
    
    if key == keys.two then
        brewType = 2
        break
    end
    
    if key == keys.three then
        brewType = 3
        break
    end
    
    if key == keys.four then
        brewType = 4
        break
    end
    
    if key == keys.five then
        brewType = 5
        break
    end
    
    if key == keys.six then
        brewType = 6
        break
    end
    
    if key == keys.seven then
        brewType = 7
        break
    end
    
    if key == keys.eight then
        brewType = 8
        break
	end
end

term.clear()
term.setCursorPos(1, 1)
print("Brew type = ", brewType)
print("Cycles? ")

brewCount = read()
brewCount = brewCount + 0

term.clear()
term.setCursorPos(1, 1)
print("Brew type = ", brewType)
print("Cycles =  ", brewCount)
print("Redstone(R) or glow powder(G-E)? ")
print("R - lenght, G - power")
print("[R]edstone, [G]low, [N]one, [E]xtra ")

brewMod = "none"

while true do
	local e,key = os.pullEvent( "key" )
	if key == keys.r then
        brewMod = "redstone"
        break
    end
    
    if key == keys.g then
        brewMod = "glowstone"
        break
    end
    
    if key == keys.n then
        brewMod = "none"
        break
    end

    if key == keys.e then
        brewMod = "extra"
        break
    end
end

term.clear()
term.setCursorPos(1, 1)
print("Brew type = ", brewType)
print("Cycles =  ", brewCount)
print("Mod =  ", brewMod)
print("Powder? [Y/N]")

brewPowder = false
while true do
	local e,key = os.pullEvent( "key" )
	if key == keys.y then
        brewPowder = true
        break
    end

    
    if key == keys.n then
        brewPowder = false
        break
    end
end

currentCycle = 0

while currentCycle < brewCount do

    ShowStats()

    BottlesToChest() -- free inventory

    TrnR()
    turtle.select(9)
    turtle.suck()

    turtle.select(10)
    turtle.suck()

    turtle.select(11)
    turtle.suck()

    TrnF()
    Back()
    Up()

    turtle.select(9)
    turtle.drop()

    turtle.select(10)
    turtle.drop()

    turtle.select(11)
    turtle.drop()

    Up()
    Fwd()
----------------------------------------------------
    Ingridient(13)
    Ingridient(brewType)

    if brewMod == "redstone" then
        Ingridient(14)
    end

    if brewMod == "glowstone" then
        Ingridient(15)
    end

    if brewMod == "extra" then
        Ingridient(15)
        Ingridient(12)
    end

    if brewPowder == true then
        Ingridient(16)
    end

    
----------------------------------------------------
    Back()
    Down()
    Down()
    Fwd()

    BottlesToChest()

    currentCycle = currentCycle + 1


end




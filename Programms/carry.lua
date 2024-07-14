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

function CompareAndDig()
	upDig = 1
    downDig = 1
 turtle.select(1)
 if turtle.compareUp() then upDig = 0 end
 if turtle.compareDown() then downDig = 0 end
 turtle.select(2)
 if turtle.compareUp() then upDig = 0 end
 if turtle.compareDown() then downDig = 0 end
 turtle.select(3)
 if turtle.compareUp() then upDig = 0 end
 if turtle.compareDown() then downDig = 0 end
 turtle.select(4)
 if turtle.compareUp() then upDig = 0 end
 if turtle.compareDown() then downDig = 0 end

 if upDig == 1 then turtle.digUp() end
 if downDig == 1 then turtle.digDown() end

end

function DigTo(z,x) 
 while TurtleZ<z do
 TrnR()
 Fwd()
 CompareAndDig()
 end

  while TurtleZ>z do
 TrnL()
 Fwd()
 CompareAndDig()
 end

 while TurtleX<x do
 TrnF()
 Fwd()
 CompareAndDig()
 end

 while TurtleX>x do
 TrnB()
 Fwd()
 CompareAndDig()
 end


end

function MoveToY(y) 
 while  TurtleY<y do
 	Up()
 end 

  while TurtleY>y do
 	Down()
  end 
end

function MoveToXYZ(z,x,y) 
 MoveTo(z,x)
 MoveToY(y)
end

function SelectAndPush(slot)
	turtle.select(slot)
	turtle.drop(64)
end

function ToBaseAndRun() 
 y =TurtleY
 MoveTo(0,0)
 MoveToY(PosToChest)
 TrnF()
 for i = 5, 16 do  -- выкинуть всё в сундук
  SelectAndPush(i)
 end

 sleep(1)


 if y<7 then os.reboot() end

 MoveTo(0,0)
 y = y - 3
 if y<6 then y=6 end
 MoveToY(y)
end

function DigLevel()
 i=0
 while i<maxZ do  
  DigTo(i,maxX)
  i=i+1
  DigTo(i,0)
  i=i+1
 end
 MoveTo(0,0)
 TrnF()
end
---------------- global ------------------
TurtleX,TurtleY,TurtleZ= 0,0,0 -- вперёд, вправо --
TurtleDirection, TurtleMove= 1,1
---------------- global ------------------

---------------- local -------------------
term.clear()
term.setCursorPos(1,1)
fuel = turtle.getFuelLevel()
print("Fuel : ",fuel)
term.setCursorPos(1,2)
write("Current Y position: ")
TurtleY = read() --позиция над коренной
TurtleY = TurtleY + 0
PosToChest = TurtleY + 1
term.clear()

term.setCursorPos(1,1)
print("Place blocks in 1-4 slot")
term.setCursorPos(1,2)
print("Place 2 chests in 5 slot")
term.setCursorPos(1,3)
write("Z quarry ")
maxZ = 15 -- макс ширина
maxZ = maxZ + 0
term.setCursorPos(1,4)
write("X quarry ")
maxX = 15 -- макс ширина
maxX = maxX + 0
term.setCursorPos(1,5)
write("Press any key to continue")
term.clear()
---------------- local -------------------


-- set chest --
Up()
Fwd()
sleep(0.5)
turtle.select(5)
turtle.place()
Back()
sleep(0.5)
turtle.place()
Down()
Down()
Down()
-- end --



-- dig --
while true do
DigLevel()
ToBaseAndRun()
end
-- end --




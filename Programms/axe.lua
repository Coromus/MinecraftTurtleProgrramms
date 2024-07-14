function Up() -- Move Up --

	DigOk = 0
        while not turtle.up() do
        	    DigOk = 1
                if not turtle.digUp() then
                        turtle.attackUp()
                end
                sleep(0.5)
        end
        turtle.dig()
     TurtleY = TurtleY + 1
end
function Down() -- Move Down --
        while not turtle.down() do
                        if not turtle.digDown() then
                                turtle.attackDown()
                        end
                        sleep(0.5)
        end
        turtle.dig()
     TurtleY = TurtleY - 1
end

function MoveToY(y) 
 while  TurtleY<y do
 	Up()
 end 

  while TurtleY>y do
 	Down()
  end 
end

function ToBase() 
        while not turtle.forward() do
                if not turtle.dig() then
                        turtle.attack()
                end
                sleep(0.5)
        end

        while not turtle.forward() do
                if not turtle.dig() then
                        turtle.attack()
                end
                sleep(0.5)
        end
 y =TurtleY
 MoveToY(0)
 sleep(1)
 os.reboot()
end

---------------- global ------------------
TurtleY= 0 -- вперёд, вправо --
DigOk = 1
---------------- global ------------------

while not turtle.forward() do
                if not turtle.dig() then
                        turtle.attack()
                end
                sleep(0.5)
end
turtle.dig()
while DigOk == 1 do
	fuel = turtle.getFuelLevel()
	if fuel < 300 then 
		turtle.refuel(1)
	end
	term.clear()
	print("Fuel : ",fuel)
	Up()
end
    ToBase()
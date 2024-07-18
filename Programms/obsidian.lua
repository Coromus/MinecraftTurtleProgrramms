function Fwd() -- Move Forward --
	while not turtle.forward() do
			sleep(0.5)
	end
end

function Dig(steps)
	i = 0
	while i<steps do  
		Fwd()
		turtle.digDown()
		i = i + 1
	   end
end

---------------- local -------------------
term.clear()
term.setCursorPos(1,1)
fuel = turtle.getFuelLevel()
print("Fuel : ",fuel)

turtle.select(1);
---------------- local -------------------




st = 1
-- dig --
turtle.digDown()

while true do
	Dig(st)
	turtle.turnRight()
	Dig(st)
	turtle.turnRight()
	st = st + 1
end
-- end --




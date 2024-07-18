pathLenght = 0

function SuckAndRefuel()
    turtle.refuel()
    turtle.placeDown()
    turtle.refuel()
end

while turtle.getFuelLevel() < turtle.getFuelLimit() do

    if not turtle.forward() then
        break
    end

    pathLenght = pathLenght + 1
    turtle.refuel()
    turtle.placeDown()
    turtle.refuel()
    
	term.clear()
	term.setCursorPos(1, 1)
	print("Fuel : ",turtle.getFuelLevel())

end

turtle.turnRight()
turtle.turnRight()

while pathLenght > 0 do
    pathLenght = pathLenght - 1
    turtle.forward()
end

turtle.turnRight()
turtle.turnRight()
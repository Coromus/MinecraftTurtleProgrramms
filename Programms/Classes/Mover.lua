---------------- class ------------------
local Mover = {}
Mover.__index = Mover
---------------- fields ------------------
Mover.x = 0
Mover.y = 0
Mover.z = 0
Mover.look = 1
Mover.move = 1
Mover.peacefulMode = false
---------------- global ------------------

local turtle = turtle;

local function sleep( time)
    
end

function Mover.new(peacefulMode)
    local self = setmetatable({}, Mover)
    self.peacefulMode = peacefulMode or false -- Значение flag по умолчанию - false
    return self
end

function Mover.__init__(peacefulMode)
    local self = { peacefulMode = peacefulMode }
    setmetatable(self, { __index = Mover })
    return self
end

function Mover:updateCoord() -- sys --
    -- print(TurtleMove)
    if self.look == 1 then
        self.x = self.x + self.move
    elseif self.look == 2 then
        self.z = self.z + self.move
    elseif self.look == 3 then
        self.x = self.x - self.move
    elseif self.look == 4 then
        self.z = self.z - self.move
    end
end

function Mover:moveUp() -- Move Up --
    while not turtle.up() do
        if not turtle.digUp() then
            if self.peacefulMode then
                sleep(0.5)
            else
                turtle.attackUp()
            end
        end
        sleep(0.5)
    end
    self.y = self.y + 1
end

function Mover:moveDown() -- Move Down --
    while not turtle.down() do
        if not turtle.digDown() then
            if self.peacefulMode then
                sleep(0.5)
            else
                turtle.attackDown()
            end
        end
        sleep(0.5)
    end
    self.y = self.y - 1
end

function Mover:moveForward() -- Move Forward --
    while not turtle.forward() do
        if not turtle.dig() then
            if self.peacefulMode then
                sleep(0.5)
            else
                turtle.attack()
            end
        end
        sleep(0.5)
    end
    self.move = 1
    self:updateCoord()
end

function Mover:moveBack() -- Move Back --
    local complete = turtle.back()
    while complete ~= true do
        complete = turtle.back()
    end
    self.move = -1
    self:updateCoord()
end

function Mover:turnRight() -- Rotate Right --
    turtle.turnRight()
    self.look = self.look + 1
    if self.look > 4 then
        self.look = self.look - 4
    end
    if self.look < 1 then
        self.look = self.look + 4
    end
end

function Mover:turnLeft() -- Rotate Left --
    turtle.turnLeft()
    self.look = self.look - 1
    if self.look > 4 then
        self.look = self.look - 4
    end
    if self.look < 1 then
        self.look = self.look + 4
    end
end

function Mover:lookForward() -- Set rotation Forward --
    if self.look == 2 then
        self:turnLeft()
    elseif self.look == 4 then
        self:turnRight()
    elseif self.look == 3 then
        self:turnLeft()
        self:turnLeft()
    end
end

function Mover:lookBack() -- Set rotation Backward --
    if self.look == 2 then
        self:turnRight()
    elseif self.look == 4 then
        self:turnLeft()
    elseif self.look == 1 then
        self:turnLeft()
        self:turnLeft()
    end
end

function Mover:lookLeft() -- Set rotation Left --
    if self.look == 3 then
        self:turnRight()
    elseif self.look == 1 then
        self:turnLeft()
    elseif self.look == 2 then
        self:turnLeft()
        self:turnLeft()
    end
end

function Mover:lookRight() -- Set rotation Right --
    if self.look == 1 then
        self:turnRight()
    elseif self.look == 3 then
        self:turnLeft()
    elseif self.look == 4 then
        self:turnLeft()
        self:turnLeft()
    end
end

function Mover:moveToXZ(x, z)
    while self.x < x do
        self:lookForward()
        self:moveForward()
    end

    while self.x > x do
        self:lookBack()
        self:moveForward()
    end

    while self.z < z do
        self:lookRight()
        self:moveForward()
    end

    while self.z > z do
        self:lookLeft()
        self:moveForward()
    end
end

function Mover:moveToY(y)
    while self.y < y do
        self:moveUp()
    end

    while self.y > y do
        self:moveDown()
    end
end

function Mover:moveToXZY(x, z, y)
    self:moveToXZ(x, z)
    self:moveToY(y)
end

return Mover

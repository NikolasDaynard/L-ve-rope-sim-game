-- Define player object

player = {
    handle1x = 100,
    handle1y = 100,
    handle2x = 200,
    handle2y = 200,
    speed = 200,
    radius = 10,
    world = nil,
    body1 = nil,
    bodies = {},
    joints = {},
    numSegments = 10,
    chainLength = 1,
    draggingIndex = -1,
}

-- Initialize method for player object
function player:init(world)
    self.world = world

    -- Create bodies for handles
    self.body1 = love.physics.newBody(self.world, self.handle1x, self.handle1y, "dynamic")

    -- Create shapes for handles (circles)
    local shape1 = love.physics.newCircleShape(self.radius)

    -- -- Attach shapes to bodies
    local fixture1 = love.physics.newFixture(self.body1, shape1)

    -- Create additional bodies and rope joints for segments
    self.bodies[1] = self.body1

    for i = 2, self.numSegments do
        local segmentX = self.handle1x + ((self.handle2x - self.handle1x) / self.numSegments) * i
        local segmentY = self.handle1y + ((self.handle2y - self.handle1y) / self.numSegments) * i

        self.bodies[i] = love.physics.newBody(self.world, segmentX, segmentY, "dynamic")

        local segmentShape = love.physics.newCircleShape(self.radius)
        local fixture1 = love.physics.newFixture(self.bodies[i], segmentShape)

        self.joints[i - 1] = love.physics.newRopeJoint(
            self.bodies[i], self.bodies[i - 1],
            segmentX, segmentY,
            self.handle1x + ((self.handle2x - self.handle1x) / self.numSegments) * (i + 1),
            self.handle1y + ((self.handle2y - self.handle1y) / self.numSegments) * (i + 1),
            self.chainLength, true
        )
        -- self.joints[i - 1]:setMaxLength(self.chainLength * 2)
    end
end  

-- Update method for player object
function player:update(dt)
    -- Update positions based on physics simulation
    self.handle1x, self.handle1y = self.body1:getPosition()
end

function player:moveHandle(newPos)
    self.body1:setPosition(newPos.x, newPos.y)
end

function player:grab(mousePos)
    if not love.mouse.isDown(1) then
        self.draggingIndex = -1
    end
    for i = 1, self.numSegments do
        local segmentX1, segmentY1 = self.bodies[i]:getPosition()
        if mousePos.x >= segmentX1 - 25 and mousePos.y >= segmentY1 - 25 and mousePos.x < segmentX1 + 25 and mousePos.y < segmentY1 + 25 and love.mouse.isDown(1) then
            self.draggingIndex = i
            print(i)
        end
    end
    if not self.draggingIndex == -1 then
        self.bodies[draggingIndex]:setPosition(mousePos.x, mousePos.y)
    end
end

-- Draw method for player object

function player:draw()
    -- Draw handles as circles
    love.graphics.circle("fill", self.handle1x, self.handle1y, self.radius)

    for i = 2, self.numSegments do
        local segmentX1, segmentY1 = self.bodies[i]:getPosition()
        local segmentX2, segmentY2 = self.bodies[i - 1]:getPosition()
        love.graphics.line(segmentX1, segmentY1, segmentX2, segmentY2)
        love.graphics.circle("fill", segmentX1, segmentY1, self.radius)
        love.graphics.circle("fill", segmentX2, segmentY2, self.radius)
    end
end
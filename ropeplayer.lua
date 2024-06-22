-- Define player object

player = {
    handle1x = 100,
    handle1y = 100,
    handle2x = 200,
    handle2y = 200,
    speed = 200,
    radius = 10,
    hitboxSize = 50,
    world = nil,
    body1 = nil,
    bodies = {},
    joints = {},
    fixtures = {},
    numSegments = 10,
    chainLength = 1,
    draggingIndex = -1,
    name = "player"
}

-- Initialize method for player object
function player:init(world)
    self.world = world

    -- Create bodies for handles
    self.body1 = love.physics.newBody(self.world, self.handle1x, self.handle1y, "dynamic")

    -- Create shapes for handles (circles)
    local shape1 = love.physics.newCircleShape(self.radius)

    -- -- Attach shapes to bodies
    player.fixtures[1] = love.physics.newFixture(self.body1, shape1)
    player.fixtures[1]:setUserData("player" .. 1)

    -- Create additional bodies and rope joints for segments
    self.bodies[1] = self.body1

    for i = 2, self.numSegments do
        local segmentX = self.handle1x + ((self.handle2x - self.handle1x) / self.numSegments) * i
        local segmentY = self.handle1y + ((self.handle2y - self.handle1y) / self.numSegments) * i

        self.bodies[i] = love.physics.newBody(self.world, segmentX, segmentY, "dynamic")

        local segmentShape = love.physics.newCircleShape(self.radius)
        player.fixtures[i] = love.physics.newFixture(self.bodies[i], segmentShape)
        player.fixtures[i]:setUserData("player" .. i)

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

function player:momentumGrab(mousePos)
    if not love.mouse.isDown(1) then
        -- apply momentum
        if self.draggingIndex ~= -1 then
            self.bodies[self.draggingIndex]:applyForce(momentumArrow:getForce().x, momentumArrow:getForce().y)
            momentumArrow:hide()
        end
        self.draggingIndex = -1
    elseif self.draggingIndex == -1 then
        for i = 1, self.numSegments do
            local segmentX, segmentY = self.bodies[i]:getPosition()
            if mousePos.x >= segmentX - self.hitboxSize and mousePos.y >= segmentY - self.hitboxSize and mousePos.x < segmentX + self.hitboxSize and mousePos.y < segmentY + self.hitboxSize then
                -- if there's already one selected, take the one with lowest distance
                if self.draggingIndex ~= -1 then
                    if distance(mousePos.x, mousePos.y, segmentX, segmentY) < distance(mousePos.x, mousePos.y, self.bodies[self.draggingIndex]:getX(), self.bodies[self.draggingIndex]:getY()) then
                        self.draggingIndex = i
                    end
                else
                    self.draggingIndex = i
                end
                momentumArrow:setOrigin(mousePos.x, mousePos.y)
                momentumArrow:show()
            end
        end
    end

    if self.draggingIndex ~= -1 then
        momentumArrow:setOrigin(self.bodies[self.draggingIndex]:getX(), self.bodies[self.draggingIndex]:getY())
        momentumArrow:setPosition(mousePos.x, mousePos.y)
    end
end

function player:isGrabbingSegment(mousePos)
    if self.draggingIndex ~= -1 then
        return true
    end
    for i = 1, self.numSegments do
        local segmentX, segmentY = self.bodies[i]:getPosition()
        if mousePos.x >= segmentX - self.hitboxSize and mousePos.y >= segmentY - self.hitboxSize and mousePos.x < segmentX + self.hitboxSize and mousePos.y < segmentY + self.hitboxSize and love.mouse.isDown(1) then
            return true
        end
    end
    return false
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


-- legacy grab, no momentum
function player:grab(mousePos)
    if not love.mouse.isDown(1) then
        self.draggingIndex = -1
    else
        for i = 1, self.numSegments do
            local segmentX, segmentY = self.bodies[i]:getPosition()
            if mousePos.x >= segmentX - self.hitboxSize and mousePos.y >= segmentY - self.hitboxSize and mousePos.x < segmentX + self.hitboxSize and mousePos.y < segmentY + self.hitboxSize then
                self.draggingIndex = i
                break -- Exit the loop once a segment is found
            end
        end
    end

    if self.draggingIndex ~= -1 then
        self.bodies[self.draggingIndex]:setPosition(mousePos.x, mousePos.y)
    end
end

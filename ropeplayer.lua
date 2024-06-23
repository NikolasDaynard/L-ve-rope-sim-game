-- Define player object

player = {
    handle1x = 100,
    handle1y = 100,
    handle2x = 200,
    handle2y = 200,
    radius = 10,
    radiusOffset = {},
    hitboxSize = 50,
    world = nil,
    body1 = nil,
    bodies = {},
    joints = {},
    fixtures = {},
    numSegments = 10,
    chainLength = 15,
    draggingIndex = -1,
    name = "player",
    deleting = false,
    invincible = false,
}

-- Initialize method for player object
function player:init()

    -- Create bodies for handles
    self.body1 = love.physics.newBody(world, self.handle1x, self.handle1y, "dynamic")

    -- Create shapes for handles (circles)
    local shape1 = love.physics.newCircleShape(self.radius)

    -- -- Attach shapes to bodies
    player.fixtures[1] = love.physics.newFixture(self.body1, shape1)
    player.fixtures[1]:setUserData("player" .. 1)

    -- Create additional bodies and rope joints for segments
    self.bodies[1] = self.body1
    self.radiusOffset[1] = 0

    for i = 2, self.numSegments do
        self.radiusOffset[i] = 0
        local segmentX = self.handle1x + ((self.handle2x - self.handle1x) / self.numSegments) * i
        local segmentY = self.handle1y + ((self.handle2y - self.handle1y) / self.numSegments) * i

        self.bodies[i] = love.physics.newBody(world, segmentX, segmentY, "dynamic")

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
    if self.deleting then
        for i = 1, self.numSegments do
            if self.radiusOffset[i] <= -10 then
                if self.radiusOffset[i + 1] ~= nil then
                    if self.radiusOffset[i + 1] > 15 then -- arbitrary
                        self.radiusOffset[i + 1] = -10
                    elseif self.radiusOffset[i + 1] > -10 then
                        self.radiusOffset[i + 1] = self.radiusOffset[i + 1] + 2
                    end
                end
                if self.radiusOffset[i - 1] ~= nil then
                    if self.radiusOffset[i - 1] > 15 then -- arbitrary
                        self.radiusOffset[i - 1] = -10
                    elseif self.radiusOffset[i - 1] > -10 then
                        self.radiusOffset[i - 1] = self.radiusOffset[i - 1] + 2
                    end
                end
            end
        end
    end
end

function player:momentumGrab(mousePos)
    if not love.mouse.isDown(1) then
        -- apply momentum
        if self.draggingIndex ~= -1 then
            levelStarted = true -- doesn't matter if set multiple times
            self.bodies[self.draggingIndex]:applyForce(momentumArrow:getForce().x, momentumArrow:getForce().y)
            score = score + 1
            momentumArrow:hide()
        end
        self.draggingIndex = -1
    elseif self.draggingIndex == -1 then
        for i = 1, self.numSegments do
            if self.radiusOffset[i] > -10 then -- skip deleted segs
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
        if self.radiusOffset[i] > -10 then
            local segmentX, segmentY = self.bodies[i]:getPosition()
            if mousePos.x >= segmentX - self.hitboxSize and mousePos.y >= segmentY - self.hitboxSize and mousePos.x < segmentX + self.hitboxSize and mousePos.y < segmentY + self.hitboxSize and love.mouse.isDown(1) then
                return true
            end
        end
    end
    return false
end

function player:isSegmentValid(segment)
    number = tonumber(string.match(segment, "%d+"))
    return self.radiusOffset[number] > -10
end

function player:won()
    self.invincible = true
end

function player:reset()
    for i = 1, self.numSegments do
        self.radiusOffset[i] = 0
    end
    player:removeMomentum() 
    self.deleting = false
    self.invincible = false
end

function player:removeMomentum() 
    for i = 1, self.numSegments do
        self.bodies[i]:setLinearVelocity(0, 0)
        self.bodies[i]:setAngularVelocity(0, 0)
    end
end

-- Draw method for player object

function player:draw()
    -- Draw handles as circles
    love.graphics.circle("fill", self.handle1x, self.handle1y, self.radius + self.radiusOffset[1])

    for i = 2, self.numSegments do
        local segmentX1, segmentY1 = self.bodies[i]:getPosition()
        local segmentX2, segmentY2 = self.bodies[i - 1]:getPosition()
        love.graphics.line(segmentX1, segmentY1, segmentX2, segmentY2)
        love.graphics.circle("fill", segmentX1, segmentY1, self.radius + self.radiusOffset[i])
        love.graphics.circle("fill", segmentX2, segmentY2, self.radius + self.radiusOffset[i - 1])
    end
end

function player:deleteSegment(segment) 
    if not self.invincible then
        number = tonumber(string.match(segment, "%d+")) 
        self.radiusOffset[number] = -10
        if self.radiusOffset[number] <= -10 then
            levelLoader:unloadLevel()
            self.deleting = true
            levelLoader:loader(levelRestartUi)
        end
    end
end
function player:applyForceToSegment(segment, x, y)
    number = tonumber(string.match(segment, "%d+")) 
    self.bodies[number]:applyForce(x, y)
end

function player:setPosition(x1, y1, x2, y2)
    -- Calculate the step size for each segment
    local stepX = (x2 - x1) / (self.numSegments - 1)
    local stepY = (y2 - y1) / (self.numSegments - 1)
    
    -- Position each segment
    for i = 1, self.numSegments do
        local newX = x1 + stepX * (i - 1)
        local newY = y1 + stepY * (i - 1)
        self.bodies[i]:setPosition(newX, newY)
    end
end

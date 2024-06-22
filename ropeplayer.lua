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
    body2 = nil,
    joint = nil
}

-- Initialize method for player object
function player:init(world)
    self.world = world

    -- Create bodies for handles
    self.body1 = love.physics.newBody(self.world, self.handle1x, self.handle1y, "dynamic")
    self.body2 = love.physics.newBody(self.world, self.handle2x, self.handle2y, "dynamic")

    -- Create shapes for handles (circles)
    local shape1 = love.physics.newCircleShape(self.radius)
    local shape2 = love.physics.newCircleShape(self.radius)

    -- Attach shapes to bodies
    local fixture1 = love.physics.newFixture(self.body1, shape1)
    local fixture2 = love.physics.newFixture(self.body2, shape2)

    -- Create rope joint between handles
    self.joint = love.physics.newRopeJoint(self.body1, self.body2, self.handle1x, self.handle1y, self.handle2x, self.handle2y, 100, true)
end

-- Update method for player object
function player:update(dt)
    -- Update positions based on physics simulation
    self.handle1x, self.handle1y = self.body1:getPosition()
    self.handle2x, self.handle2y = self.body2:getPosition()
end

function player:moveHandle(newPos)
    self.body1:setPosition(newPos.x, newPos.y)
end

-- Draw method for player object
function player:draw()
    -- Draw handles as circles
    love.graphics.circle("fill", self.handle1x, self.handle1y, self.radius)
    love.graphics.circle("fill", self.handle2x, self.handle2y, self.radius)

    -- Draw rope segment
    love.graphics.line(self.handle1x, self.handle1y, self.handle2x, self.handle2y)
end

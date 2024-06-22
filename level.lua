function createBoundaries()
    local windowWidth, windowHeight = love.graphics.getDimensions()
    
    -- Create static bodies for each edge of the window
    local boundaries = {
        top = love.physics.newBody(world, windowWidth / 2, 0, "static"),
        bottom = love.physics.newBody(world, windowWidth / 2, windowHeight, "static"),
        left = love.physics.newBody(world, 0, windowHeight / 2, "static"),
        right = love.physics.newBody(world, windowWidth, windowHeight / 2, "static")
    }

    -- Create shapes for each boundary
    local shapes = {
        top = love.physics.newEdgeShape(-windowWidth / 2, 0, windowWidth / 2, 0),
        bottom = love.physics.newEdgeShape(-windowWidth / 2, 0, windowWidth / 2, 0),
        left = love.physics.newEdgeShape(0, -windowHeight / 2, 0, windowHeight / 2),
        right = love.physics.newEdgeShape(0, -windowHeight / 2, 0, windowHeight / 2)
    }

    -- Attach shapes to bodies with fixtures
    for _, body in pairs(boundaries) do
        local shape = shapes[_]
        love.physics.newFixture(body, shape)
    end
end

-- Spike object definition
local spike = {
    x = 500, 
    y = 200, 
    width = 50,
    height = 50,
    body = nil,
}

function beginContact(a, b, coll)
	local textA = a:getUserData()
	local textB = b:getUserData()
    if type(textA) == "string" then
        if string.find(textA, "player") ~= nil then
            -- player:deleteSegment(textA)
            print(textA)
        end
    elseif type(textB) == "string" then
        if string.find(textB, "player") ~= nil then
            -- player:deleteSegment(textB)
            print(textB)
        end
    end
end
function loadlevel()
    spike.body = love.physics.newBody(world, spike.x, spike.y, "dynamic")
    spike.shape = love.physics.newRectangleShape(spike.width, spike.height)
    spike.fixture = love.physics.newFixture(spike.body, spike.shape)

    -- Set fixture user data to spike object
    spike.fixture:setUserData(spike)

    -- Set collision callback function
    world:setCallbacks(beginContact)

    -- Set collision filter if needed
    spike.fixture:setCategory(1) -- Example category
end

function renderLevel() 
    love.graphics.rectangle("fill", spike.body:getX() - (spike.width / 2), spike.body:getY() - (spike.height / 2), spike.width, spike.height)
end
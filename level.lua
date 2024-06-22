require("levels")

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

function beginContact(a, b, coll)
	local textA = a:getUserData()
	local textB = b:getUserData()
    if type(textA) == "string" and type(textB) == "string" then
        if string.find(textB, "player") ~= nil and string.find(textA, "spike") ~= nil then
            player:deleteSegment(textB)
        end
    end
end
function loadlevel()
    for key, value in pairs(level1) do
        if value.type == "spike" then
            value.body = love.physics.newBody(world, value.x, value.y, "dynamic")
            value.shape = love.physics.newRectangleShape(value.width, value.height)
            value.fixture = love.physics.newFixture(value.body, value.shape)
            -- Set fixture user data to spike object
            value.fixture:setUserData("spike")

            value.fixture:setCategory(1) 
        elseif value.type == "player" then
            player.handle1x = value.handle1x
            player.handle1y = value.handle1y
            player.handle2x = value.handle2x
            player.handle2y = value.handle2y
            player:init()
        end
    end
    -- Set collision callback function
    world:setCallbacks(beginContact)

end

function renderLevel() 
    for key, value in pairs(level1) do
        if value.render == "rectangle" then
            love.graphics.rectangle("fill", value.body:getX() - (value.width / 2), value.body:getY() - (value.height / 2), value.width, value.height)
        end
    end


    
end
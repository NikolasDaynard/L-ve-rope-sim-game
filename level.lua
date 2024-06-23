-- require("levels")

loadedLevel = nil

levelLoader = {}

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
        elseif string.find(textB, "player") ~= nil and string.find(textA, "finish") ~= nil then
            -- skips the setting of the level because it's jsut ui so it's handled by ui
            levelLoader:loader(levelfinishUi)
        elseif string.find(textB, "player") ~= nil and string.find(textA, "spring") ~= nil then
            
            player:applyForceToSegment(textB, 0, -10000)
        elseif string.find(textB, "emp") ~= nil and string.find(textA, "player") ~= nil then
            player:applyForceToSegment(textA, 0, -10000)
            index = tonumber(string.match(textB, "%d+")) 
            local tableAtIndex = levelLoader:findTableAtIndex(index, "emp")
            tableAtIndex.empTimer = tableAtIndex.empTimer - .001
        end
    end
end

function levelLoader:findTableAtIndex(indexToFind, type)
    local currentNum = 1
    for key, value in pairs(loadedLevel) do
        if value.type == type then
            if currentNum == indexToFind then
                return value
            end
            currentNum = currentNum + 1
        end
    end
    return nil
end

function levelLoader:loader(level)
    if level ~= nil then
        local empIndex = 1
        for key, value in pairs(level) do
            if value.type == "spike" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(value.width, value.height)
                value.fixture = love.physics.newFixture(value.body, value.shape)
                -- Set fixture user data to spike object
                value.fixture:setUserData("spike")

                value.fixture:setCategory(1) 
            elseif value.type == "player" then
                player:setPosition(value.handle1x, value.handle1y, value.handle2x, value.handle2y)
                player:reset()
            elseif value.type == "wall" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(value.width, value.height)
                value.fixture = love.physics.newFixture(value.body, value.shape)
            elseif value.type == "spring" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(value.width, value.height)
                value.fixture = love.physics.newFixture(value.body, value.shape)
                value.fixture:setUserData("spring")

                value.fixture:setCategory(1) 
                value.fixture:setSensor(true) -- no collision
            elseif value.type == "emp" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newCircleShape(value.radius)
                value.fixture = love.physics.newFixture(value.body, value.shape)

                value.triggerBody = love.physics.newBody(world, value.x, value.y, "static")
                value.triggerShape = love.physics.newCircleShape(value.triggerRadius)
                value.triggerFixture = love.physics.newFixture(value.triggerBody, value.triggerShape)
                value.triggerFixture:setUserData("emp" .. empIndex)
                value.triggerFixture:setCategory(1)
                value.triggerFixture:setSensor(true)
                value.empTimer = 3
                empIndex = empIndex + 1

            elseif value.type == "finish" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(value.width, value.height)
                value.fixture = love.physics.newFixture(value.body, value.shape)
                -- Set fixture user data to spike object
                value.fixture:setUserData("finish")
                value.fixture:setCategory(1) 
            elseif value.type == "button" then
                ui:addButton(value.x, value.y, value.w, value.h, value.callback, value.text)
            elseif value.type == "par" then
                par = value.value
            end
        end
        -- Set collision callback function
        world:setCallbacks(beginContact)
    end
end

function levelLoader:loadLevel(levelToLoad)
    score = 0
    -- if it's exists set it, otherwise reload level
    if levelToLoad ~= nil then
        loadedLevel = levelToLoad
    end
    levelLoader:loader(loadedLevel)
end
function levelLoader:unloadLevel()
    if loadedLevel ~= nil then
        ui:clear()
        for key, value in pairs(loadedLevel) do
            if value.fixture ~= nil then
                value.fixture:destroy()
            end
            if value.body ~= nil then
                value.body:destroy()
            end
            if value.shape ~= nil then
                value.shape = nil
            end
            if value.triggerFixture ~= nil then
                value.triggerFixture:destroy()
            end
            if value.triggerBody ~= nil then
                value.triggerBody:destroy()
            end
            if value.triggerShape ~= nil then
                value.triggerShape = nil
            end
            value = nil
        end

        loadedLevel = nil
    end
end

function levelLoader:updateLevel(dt) 
    for key, value in pairs(loadedLevel) do
        if value.type == "finish" then
        elseif value.type == "spike" then
        elseif value.type == "spring" then
        elseif value.type == "emp" then
            if value.empTimer < 3 then
                value.empTimer = value.empTimer - (1.8 * dt)
            end
        end
    end
end

function levelLoader:renderLevel() 
    if loadedLevel ~= nil then
        for key, value in pairs(loadedLevel) do
            if value.type == "finish" then
                love.graphics.setColor(0.2, 1, 0.2)
            elseif value.type == "spike" then
                love.graphics.setColor(1, 0.2, 0.2)
            elseif value.type == "spring" then
                love.graphics.setColor(1, 0.7, 0.5)
            elseif value.type == "emp" then
                if value.empTimer < 3 and value.empTimer > 2.5 then
                    love.graphics.setColor(0.7, 0.7 * (value.empTimer / 5), 0.3)
                elseif value.empTimer < 2 and value.empTimer > 1.5 then
                    love.graphics.setColor(0.7, 0.7 * (value.empTimer / 5), 0.3) 
                elseif value.empTimer < 1 and value.empTimer > .5 then
                    love.graphics.setColor(0.7, 0.7 * (value.empTimer / 5), 0.3) 
                elseif value.empTimer < 0 then
                    love.graphics.setColor(0, 0, 0) 
                end
                
                love.graphics.circle("line", value.body:getX(), value.body:getY(), value.triggerRadius)
            end
            if value.render == "rectangle" then
                love.graphics.rectangle("fill", value.body:getX() - (value.width / 2), value.body:getY() - (value.height / 2), value.width, value.height)
                love.graphics.setColor(1, 1, 1)
            elseif value.render == "circle" then
                love.graphics.circle("fill", value.body:getX(), value.body:getY(), value.radius)
                love.graphics.setColor(1, 1, 1)
            end
        end
    end
end
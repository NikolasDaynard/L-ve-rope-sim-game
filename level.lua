loadedLevel = nil
previousLevel = nil

levelLoader = {}

function createBoundaries()
    local windowWidth, windowHeight = love.graphics.getDimensions()
    windowWidth = 1440
    windowHeight = 900
    
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
            -- skips the setting of the level because it's just ui so it's handled by ui
            if player:isSegmentValid(textB) then
                levelLoader:loader(levelfinishUi)
            end
            if levelScores[currentLevelId] ~= nil then
                if levelScores[currentLevelId] > score then
                    levelScores[currentLevelId] = score
                end
                if levelScores[currentLevelId] == nil then
                    levelScores[currentLevelId] = score
                end
            else
                levelScores[currentLevelId] = score
            end
            local jsonString = lunajson.encode(levelScores)
            love.filesystem.write("highscore.json", jsonString)
            player:won()
            loadLevelScoreImages()

        elseif string.find(textB, "player") ~= nil and string.find(textA, "spring") ~= nil then
            index = tonumber(string.match(textA, "%d+")) 
            local tableAtIndex = levelLoader:findTableAtIndex(index, "spring")
            player:applyForceToSegment(textB, 0, -10000 * tableAtIndex.force)
            soundLib:playSound("sounds/spring.wav")

        elseif string.find(textB, "emp") ~= nil and string.find(textA, "player") ~= nil then
            index = tonumber(string.match(textB, "%d+")) 
            local tableAtIndex = levelLoader:findTableAtIndex(index, "emp")
            tableAtIndex.empTimer = tableAtIndex.empTimer - .001
        elseif string.find(textA, "physics") ~= nil and string.find(textB, "player") ~= nil then
            index = tonumber(string.match(textA, "%d+")) 
            local tableAtIndex = levelLoader:findTableAtIndex(index, "physics")
            -- defaults to up
            local angle = (tableAtIndex.rotation or 0) + 90
            local forceX = -10000 * math.cos(math.rad(angle)) * (tableAtIndex.force or 1)
            local forceY = -10000 * math.sin(math.rad(angle)) * (tableAtIndex.force or 1)
            player:applyForceToSegment(textB, forceX, forceY)
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
        local springIndex = 1
        local physicsIndex = 1
        for key, value in pairs(level) do
            if value.type == "spike" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(0, 0, value.width, value.height, math.rad(value.rotation or 0))
                value.fixture = love.physics.newFixture(value.body, value.shape)
                -- Set fixture user data to spike object
                value.fixture:setUserData("spike")

                value.fixture:setCategory(1) 
            elseif value.type == "player" then
                player:setPosition(value.handle1x, value.handle1y, value.handle2x, value.handle2y)
                player:reset()
            elseif value.type == "wall" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(0, 0, value.width, value.height, math.rad(value.rotation or 0))
                value.fixture = love.physics.newFixture(value.body, value.shape)
            elseif value.type == "spring" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(value.width, value.height)
                value.fixture = love.physics.newFixture(value.body, value.shape)
                value.fixture:setUserData("spring" .. springIndex)

                if value.force == nil then
                    value.force = 1
                end

                value.fixture:setCategory(1) 
                value.fixture:setSensor(true) -- no collision
                springIndex = springIndex + 1
            elseif value.type == "physics" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(0, 0, value.width, value.height, math.rad(value.rotation or 0))
                value.fixture = love.physics.newFixture(value.body, value.shape)
                value.fixture:setUserData("physics" .. physicsIndex)

                if value.force == nil then
                    value.force = 1
                end

                value.fixture:setCategory(1) 
                value.fixture:setSensor(true) -- no collision
                physicsIndex = physicsIndex + 1
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
                if value.speed == nil then
                    value.speed = 1
                end
                empIndex = empIndex + 1

            elseif value.type == "finish" then
                value.body = love.physics.newBody(world, value.x, value.y, "static")
                value.shape = love.physics.newRectangleShape(value.width, value.height)
                value.fixture = love.physics.newFixture(value.body, value.shape)
                -- Set fixture user data to spike object
                value.fixture:setUserData("finish")
                value.fixture:setCategory(1) 
            elseif value.type == "button" then
                ui:addButton(value.x, value.y, value.w, value.h, value.callback, value.text, interpolate(value.image), value.render, value.sliceSize)
            elseif value.type == "slider" then
                ui:addSlider(value.x, value.y, value.w, value.h, value.callback, value.text, value.minValue, value.maxValue, value.value, value.barImage, value.nubImage, value.render, value.sliceSize)
            elseif value.type == "par" then
                par = value.value
            elseif value.type == "id" then
                currentLevelId = value.value
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
        previousLevel = loadedLevel
        loadedLevel = levelToLoad
    end
    levelLoader:loader(loadedLevel)
end
function levelLoader:unloadLevel()
    levelStarted = false
    currentLevelId = nil
    if loadedLevel ~= nil then
        previousLevel = loadedLevel
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
    if loadedLevel ~= nil then
        for key, value in pairs(loadedLevel) do
            if value.type == "finish" then
            elseif value.type == "spike" then
            elseif value.type == "spring" then
            elseif value.type == "emp" then
                if value.empTimer < 3 then
                    value.empTimer = value.empTimer - (2.2 * dt * value.speed)
                    if value.empTimer < 0 then
                        if value.triggerFixture ~= nil then
                            -- kinda jank but this means it's the first time so explosion code goes here
                            for i = 1, player.numSegments do
                                local segmentX, segmentY = player.bodies[i]:getPosition()
                                if distance(segmentX, segmentY, value.body:getX(), value.body:getY()) < value.triggerRadius then
                                    player.radiusOffset[i] = -10
                                end
                            end
                            
                            value.triggerFixture:destroy()
                            value.fixture:destroy()
                            value.triggerFixture = nil
                            value.fixture = nil
                        end
                        if value.triggerBody ~= nil then
                            value.triggerBody:destroy()
                            value.triggerBody = nil
                        end
                        if value.triggerShape ~= nil then
                            value.triggerShape = nil
                            value.shape = nil
                        end
                    end
                end
            end
        end
    end
end

function levelLoader:renderLevel() 
    if loadedLevel ~= nil then
        for key, value in pairs(loadedLevel) do
            love.graphics.setColor(1, 1, 1)
            if value.type == "finish" then
                love.graphics.setColor(0.2, 1, 0.2)
            elseif value.type == "wall" then
                love.graphics.setColor(1, 1, 1)
            elseif value.type == "spike" then
                love.graphics.setColor(1, 0.2, 0.2)
            elseif value.type == "spring" then
                love.graphics.setColor(1, 0.7, 0.5)
            elseif value.type == "physics" then
                love.graphics.setColor(0.2, 0.3, 1, .5)
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
                if value.empTimer > 0 then
                    love.graphics.circle("line", value.body:getX(), value.body:getY(), value.triggerRadius)
                end
            end
            if value.render == "rectangle" then
                drawRotatedRect("fill", value.body:getX() - (value.width / 2), value.body:getY() - (value.height / 2), value.width, value.height, -math.rad(value.rotation or 0))
                love.graphics.setColor(1, 1, 1)
            elseif value.render == "circle" then
                love.graphics.circle("fill", value.body:getX(), value.body:getY(), value.radius)
                love.graphics.setColor(1, 1, 1)
            end
            love.graphics.setColor(1, 1, 1)
        end
    end
end
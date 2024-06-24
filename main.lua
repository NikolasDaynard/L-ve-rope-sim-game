require ("helpers")
require("ropeplayer")
require("momentumArrow")
require("level")
require("levels")
require("ui")
require("image")
lunajson = require("libs.lunajson")
Camera = require 'camera' 
font = love.graphics.setNewFont("Early GameBoy.ttf", 15, "normal", 1)
love.graphics.setFont(font)

score = 0
par = 0
levelScores = {}
currentLevelId = nil
levelStarted = false

draggingPlayer = false

-- Load function
function love.load()
    if love.filesystem.getInfo("highscore.json") ~= nil then
        local fileData = love.filesystem.read("highscore.json")
        levelScores = lunajson.decode(fileData)
    end

    cam = Camera()
    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    -- Calculate a desired aspect ratio (e.g., 16:9)
    local aspectRatio = 16 / 9
    local windowWidth = screenWidth
    local windowHeight = screenHeight
    if screenWidth / screenHeight > aspectRatio then
        windowWidth = screenHeight * aspectRatio
    else
        windowHeight = screenWidth / aspectRatio
    end
    -- Calculate zoom based on the smaller dimension, so smaller screens see the same amound of level
    local intendedZoom = math.min(windowWidth / screenWidth, windowHeight / screenHeight)
    cam:zoomTo(intendedZoom * 1.105)
    cam:lookAt(screenWidth / 2, screenHeight / 2)

    -- Set fullscreen with borders
    love.window.setMode(windowWidth, windowHeight, {
        fullscreen = true,
        fullscreentype = "desktop",
        resizable = true,
        borderless = false
    })
    -- Initialize physics world
    world = love.physics.newWorld(0, 300, true)
    createBoundaries()
    -- Initialize player with physics has to be before level
    player:init()
    levelLoader:loadLevel(titlescreen)

    love.graphics.setBackgroundColor(.2, .2, .2)

end

-- Update function
function love.update(dt)
    if not levelStarted then
        dt = dt / 100 -- still want player to unfurl
    end
    
    -- slow when grabbing
    if player:isGrabbingSegment({x = cam:mousePosition().x, y = cam:mousePosition().y}) then
        dt = dt / 10
    end
    
    if love.keyboard.isDown("escape") then
        love.window.close()
        love.event.quit()
    end
    if love.keyboard.isDown("0") then
        levelLoader:unloadLevel()
        levelLoader:loadLevel(titlescreen)
    end
    if love.keyboard.isDown("1") then
        levelLoader:unloadLevel()
        levelLoader:loadLevel(level1)
    end
    if love.keyboard.isDown("2") then
        levelLoader:unloadLevel()
        levelLoader:loadLevel(level2)
    end

    local velocityIterations = 10
    local positionIterations = 1
    world:update(dt, velocityIterations, positionIterations)

    player:update(dt)
    player:momentumGrab({x = cam:mousePosition().x, y = cam:mousePosition().y})

    levelLoader:updateLevel(dt)
    -- ui is unnafected by camera transforms
    ui:update({x = love.mouse.getX(), y = love.mouse.getY()})
end

-- Draw function
function love.draw()
    -- cam:move(0, 0)

    cam:attach()
    -- love.graphics.setColor(1, .7, .7)
    momentumArrow:render()
    levelLoader:renderLevel()
    player:draw()
    cam:detach()
    -- ui is unaffected by scaling 
    ui:render()
    love.graphics.print("shots: " .. score .. " . " .. par, 0, 0, 0, 1, 1)
end

require ("helpers")
require("ropeplayer")
require("momentumArrow")
require("level")
require("levels")
Camera = require 'camera' 

draggingPlayer = false

-- Load function
function love.load()
    love.window.setTitle("Rope Game")
    cam = Camera()
    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    -- Calculate a desired aspect ratio (e.g., 16:9)
    local aspectRatio = 16 / 9
    local windowWidth = math.min(screenWidth, math.floor(screenHeight * aspectRatio)) / 2
    local windowHeight = math.min(screenHeight, math.floor(screenWidth / aspectRatio)) / 2
    cam:lookAt(screenWidth / 2, screenHeight / 2)

    -- Set fullscreen with borders
    love.window.setMode(windowWidth, windowHeight, {
        fullscreen = true,
        fullscreentype = "desktop",
        resizable = true,
        borderless = false
    })
    -- Initialize physics world
    world = love.physics.newWorld(0, 100, true)
    createBoundaries()
    -- Initialize player with physics has to be before level
    player:init()
    levelLoader:loadLevel(level1)
end

-- Update function
function love.update(dt)
    
    -- slow when grabbing
    if player:isGrabbingSegment({x = cam:mousePosition().x, y = cam:mousePosition().y}) then
        dt = dt / 15
    end
    
    if love.keyboard.isDown("escape") then
        love.window.close()
        love.event.quit()
    end
    if love.keyboard.isDown("0") then
        levelLoader:unloadLevel()
    end
    if love.keyboard.isDown("1") then
        levelLoader:unloadLevel()
        levelLoader:loadLevel(level1)
    end
    if love.keyboard.isDown("2") then
        levelLoader:unloadLevel()
        levelLoader:loadLevel(level2)
    end
    world:update(dt)

    player:update(dt)
    player:momentumGrab({x = love.mouse.getX(), y = love.mouse.getY()})
end

-- Draw function
function love.draw()
    -- cam:move(0, 0)

    cam:attach()
    player:draw(camera)
    momentumArrow:render(camera)
    levelLoader:renderLevel(camera)
    cam:detach()
end

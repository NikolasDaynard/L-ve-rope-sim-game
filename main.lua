require ("helpers")
require("ropeplayer")
require("momentumArrow")
require("level")
draggingPlayer = false

-- Load function
function love.load()
    love.window.setTitle("Rope Game")
    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    -- Calculate a desired aspect ratio (e.g., 16:9)
    local aspectRatio = 16 / 9
    local windowWidth = math.min(screenWidth, math.floor(screenHeight * aspectRatio))
    local windowHeight = math.min(screenHeight, math.floor(screenWidth / aspectRatio))

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

    -- Initialize player with physics
    player:init(world)
end

-- Update function
function love.update(dt)
    
    -- slow when grabbing
    if player:isGrabbingSegment({x = love.mouse.getX(), y = love.mouse.getY()}) then
        dt = dt / 20
    end
    
    if love.keyboard.isDown("escape") then
        love.window.close()
        love.event.quit()
    end
    world:update(dt)

    player:update(dt)
    player:momentumGrab({x = love.mouse.getX(), y = love.mouse.getY()})
end

-- Draw function
function love.draw()
    player:draw()
    love.graphics.rectangle("fill", 0, 0, 10, 10)
    momentumArrow:render()
end

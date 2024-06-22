require ("helpers")
require("ropeplayer")
require("momentumArrow")
draggingPlayer = false

-- Load function
function love.load()
    love.window.setTitle("Rope Game")
    love.window.setMode(400, 300)
    -- Initialize physics world
    world = love.physics.newWorld(0, 100, true)
    -- love.physics.setMeter(100)
    -- world:speed = .2

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

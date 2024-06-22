require("ropeplayer")
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
    -- if love.mouse.getX() >= player.handle1x - 25 and love.mouse.getY() >= player.handle1y - 25 and love.mouse.getX() < player.handle1x + 25 and love.mouse.getY() < player.handle1y + 25 and love.mouse.isDown(1) then
    --     draggingPlayer = true
    -- end
    -- if draggingPlayer then

    --     player:moveHandle({x = love.mouse.getX(), y = love.mouse.getY()})
    --     if not love.mouse.isDown(1) then
    --         draggingPlayer = false
    --     end
    -- end
    if love.keyboard.isDown("escape") then
        love.window.close()
        love.event.quit()
    end
    world:update(dt)

    player:update(dt)
    player:grab({x = love.mouse.getX(), y = love.mouse.getY()})
end

-- Draw function
function love.draw()
    -- Draw the player as a simple rectangle
    player:draw()
end

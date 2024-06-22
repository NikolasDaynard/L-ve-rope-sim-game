require("ropeplayer")
draggingPlayer = false

-- Load function
function love.load()
    love.window.setTitle("Rope Game")
    love.window.setMode(400, 300)
    -- Initialize physics world
    world = love.physics.newWorld(0, 10, true)
    -- world:speed = .2

    -- Initialize player with physics
    player:init(world)
end

-- Update function
function love.update(dt)
    if love.mouse.getX() >= player.handle1x and love.mouse.getY() >= player.handle1y and love.mouse.getX() < player.handle1x + 50 and love.mouse.getY() < player.handle1y + 50 and love.mouse.isDown(1) then
        draggingPlayer = true
    end
    if draggingPlayer then

        player:moveHandle({x = love.mouse.getX(), y = love.mouse.getY()})
        if not love.mouse.isDown(1) then
            draggingPlayer = false
        end
    end
    if love.keyboard.isDown("escape") then
        love.window.close()
        love.event.quit()
    end
    world:update(dt)

    player:update(dt)
end

-- Draw function
function love.draw()
    -- Draw the player as a simple rectangle
    -- love.graphics.rectangle("fill", player.handle1x, player.handle1y, 50, 50)
    -- love.graphics.circle("fill", player.handle1x + 25, player.handle1y + 25, 50, 50)
    player:draw()
end

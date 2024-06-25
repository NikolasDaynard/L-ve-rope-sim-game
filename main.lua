require ("helpers")
require("ropeplayer")
require("momentumArrow")
require("level")
require("levels")
require("ui")
require("image")
require("sound")
lunajson = require("libs.lunajson")
Camera = require 'camera' 
font = love.graphics.setNewFont("Early GameBoy.ttf", 15, "normal", 1)
love.graphics.setFont(font)

score = 0
par = 0
levelScores = {}
levelImages = {}
currentLevelId = nil
levelStarted = false
pressingesc = false
-- defaults
settings = {}

draggingPlayer = false

-- Load function
function love.load()
    if love.filesystem.getInfo("highscore.json") ~= nil then
        local fileData = love.filesystem.read("highscore.json")
        levelScores = lunajson.decode(fileData)
    end
    if love.filesystem.getInfo("settings.json") ~= nil then
        local fileData = love.filesystem.read("settings.json")
        settings = lunajson.decode(fileData)
    else
        settings.volume = 1
    end

    loadLevelScoreImages()

    cam = Camera()
    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    -- Set fullscreen with borders
    love.window.setMode(screenWidth, screenHeight, {
        fullscreen = true,
        fullscreentype = "desktop",
        resizable = true,
        borderless = false
    })
    -- Initialize physics world
    world = love.physics.newWorld(0, 300, true)
    createBoundaries()

    screenWidth, screenHeight = love.window.getDesktopDimensions()
    love.resize(screenWidth, screenHeight)
    -- Initialize player with physics has to be before level
    player:init()
    levelLoader:loadLevel(titlescreen)

    love.graphics.setBackgroundColor(.2, .2, .2)
end

function love.resize(w, h)
    local aspectRatio = 16 / 9
    local windowWidth, windowHeight

    -- Calculate window dimensions based on aspect ratio
    if w / h > aspectRatio then
        windowWidth = h * aspectRatio
        windowHeight = h
    else
        windowWidth = w
        windowHeight = w / aspectRatio
    end

    -- Calculate zoom based on the smaller dimension
    local intendedZoom = math.min(windowWidth / 1440, windowHeight / 900)
    local scaledZoom = 1

    -- Adjust zoom only if the screen width is less than 1440
    if w < 1440 then
        scaledZoom = (w / 1440) * 0.9945
    end
    if h < 900 then
        scaledZoom = math.min((h / 900) * 0.9945, scaledZoom)
    end

    cam:zoomTo(scaledZoom)

    -- Center the camera view
    cam:lookAt((1440) / 2, 900 / 2)
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
    
    if love.keyboard.isDown("q") then
        exitGame()
    end
    if love.keyboard.isDown("escape") then
        if ui:doesButtonExist(interpolate(settingsUi.textButton.text)) and not pressingesc then
            ui:remove(settingsUi)
            levelStarted = true
        elseif not pressingesc then
            levelStarted = false
            levelLoader:loader(settingsUi)
        end
        pressingesc = true
    else
        pressingesc = false
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
    soundLib:update()
    soundLib:loop("sounds/soundtrack.mp3")
    ui:update({x = cam:mousePosition().x, y = cam:mousePosition().y})
end

-- Draw function
function love.draw()
    -- cam:move(0, 0)

    cam:attach()
    -- love.graphics.setColor(1, .7, .7)
    momentumArrow:render()
    levelLoader:renderLevel()
    player:draw()
    ui:render()
    cam:detach()
    love.graphics.print("shots: " .. score .. " . " .. par, 0, 0, 0, 1, 1)
end

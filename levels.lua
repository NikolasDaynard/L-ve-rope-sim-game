require("level")

local screenWidth, screenHeight = love.window.getDesktopDimensions()

-- Spike object definition
local function levelLoadCallback(level)
    levelLoader:unloadLevel()
    levelLoader:loadLevel(level)
end

titlescreen = {
    playerinfo = {
        type = "player",
        handle1x = -100,
        handle1y = -100,
        handle2x = -100,
        handle2y = -100
    },
    start = {
        type = "button",
        x = (screenWidth / 2) - 250,
        y = 400,
        w = 500,
        h = 20,
        text = "Start!",
        callback = function()
            levelLoadCallback(levelselectionscreen)
        end,
    }
}

level1 = {
    playerinfo = {
        type = "player",
        handle1x = 90,
        handle1y = 850,
        handle2x = 90,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 4
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 600,
        y = 900,
        width = 300,
        height = 600,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 700,
        y = 900,
        width = 300,
        height = 300,
    },
}
levelfinishUi = {
    finishButton = {
        type = "button",
        x = (screenWidth / 2) - (screenWidth / 7),
        y = screenHeight / 2,
        w = (screenWidth / 3.5),
        h = screenHeight / 4,
        text = "level donesies",
        callback = function()
            levelLoadCallback(levelselectionscreen)
        end,
    }
}
level2 = {
    playerinfo = {
        type = "player",
        handle1x = 90,
        handle1y = 90,
        handle2x = 300,
        handle2y = 300
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    spike = {
        render = "rectangle",
        type = "spike",
        x = 300, 
        y = 200, 
        width = 50,
        height = 50,
        body = nil,
    },
    spike2 = {
        render = "rectangle",
        type = "spike",
        x = 200, 
        y = 400, 
        width = 50,
        height = 50,
        body = nil,
    },
}

--[[
level selection screen will look like this
[1] [2] [3]
[4] [5] [6]
ect.
]]--
levelselectionscreen = {
    -- hide player (jank? In my game?)
    playerinfo = {
        type = "player",
        handle1x = -100,
        handle1y = -100,
        handle2x = -100,
        handle2y = -100
    },
    level1select = {
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = 400,
        w = screenWidth / 7,
        h = 20,
        text = "1 par:" .. level1.par.value,
        callback = function()
            levelLoadCallback(level1)
        end,
    },
    level2select = {
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = 400,
        w = screenWidth / 7,
        h = 20,
        text = "2",
        callback = function()
            levelLoadCallback(level2)
        end,
    },
    level3select = {
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = 400,
        w = screenWidth / 7,
        h = 20,
        text = "3",
        callback = function()
            -- levelLoadCallback(level3)
        end,
    }

}
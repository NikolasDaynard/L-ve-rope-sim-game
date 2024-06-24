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
        render = "slice",
        image = "balluilarge.png",
        sliceSize = 300,
        x = (screenWidth / 2) - 250,
        y = 300,
        w = 500,
        h = 400,
        text = "Start!",
        callback = function()
            levelLoadCallback(levelselectionscreen)
        end,
    }
}
levelfinishUi = {
    finishButton = {
        type = "button",
        render = "slice",
        image = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 7),
        y = screenHeight / 3,
        w = (screenWidth / 3.5),
        h = screenHeight / 4,
        text = "level donesies \n ${score} to par ${par}",
        callback = function()
            levelLoadCallback(levelselectionscreen)
        end,
    }
}
levelRestartUi = {
    infoButton = {
        render = "slice",
        image = "balluilarge.png",
        sliceSize = 240,
        type = "button",
        x = (screenWidth / 2) - (screenWidth / 7),
        y = screenHeight / 4,
        w = (screenWidth / 3.5),
        h = screenHeight / 2,
        text = "\n\n\nLevel lost\n\n\nRestart?\n\n\n",
        callback = function()
            ui:clear()
            levelLoadCallback(previousLevel)
        end,
    },
}

level1 = {
    id = {
        type = "id",
        value = 1
    },
    playerinfo = {
        type = "player",
        handle1x = 90,
        handle1y = 850,
        handle2x = 90,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 3
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall1 = {
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
        x = 800,
        y = 900,
        width = 100,
        height = 300,
    },
}
level2 = {
    id = {
        type = "id",
        value = 2
    },
    playerinfo = {
        type = "player",
        handle1x = 60,
        handle1y = 850,
        handle2x = 90,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 4
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 600,
        y = 500,
        width = 300,
        height = 730,
    },
    spring = {
        render = "rectangle",
        type = "spring",
        x = 850,
        y = 900,
        width = 100,
        height = 100,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 800,
        y = 700,
        width = 100,
        height = 200,
    },
}
level3 = {
    id = {
        type = "id",
        value = 3
    },
    playerinfo = {
        type = "player",
        handle1x = 9,
        handle1y = 80,
        handle2x = 30,
        handle2y = 60
    },
    par = {
        type = "par",
        value = 2
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 50,
        y = 530,
        width = 100,
        height = 740,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 100,
        y = 530,
        width = 100,
        height = 740,
    },
    spike = {
        render = "rectangle",
        type = "spike",
        x = 650, 
        y = 700,
        width = 1000,
        height = 400,
        body = nil,
    },
    spike2 = {
        render = "rectangle",
        type = "spike",
        x = 1100, 
        y = 700, 
        width = 50,
        height = 500,
        body = nil,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1300,
        y = 900,
        width = 100,
        height = 300,
    },
}
level4 = {
    id = {
        type = "id",
        value = 4
    },
    playerinfo = {
        type = "player",
        handle1x = 9,
        handle1y = 890,
        handle2x = 30,
        handle2y = 860
    },
    par = {
        type = "par",
        value = 3
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 200,
        y = 800,
        width = 100,
        height = 500,
    },
    spike1 = {
        render = "rectangle",
        type = "spike",
        x = 200, 
        y = 525, 
        width = 50,
        height = 50,
        body = nil,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 800,
        y = 900,
        width = 100,
        height = 300,
    },
}
level5 = {
    id = {
        type = "id",
        value = 5
    },
    playerinfo = {
        type = "player",
        handle1x = 9,
        handle1y = 890,
        handle2x = 30,
        handle2y = 860
    },
    par = {
        type = "par",
        value = 3
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    spring1 = {
        render = "rectangle",
        type = "spring",
        force = 10,
        x = 300,
        y = 880,
        width = 100,
        height = 40,
    },
    spike1 = {
        render = "rectangle",
        type = "spike",
        x = 300,
        y = 580,
        width = 1000,
        height = 40,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 800,
        y = 900,
        width = 100,
        height = 300,
    },
}
--[[
    0     |
    |     |
    |+ = +|
]]--
level6 = {
    id = {
        type = "id",
        value = 6
    },
    playerinfo = {
        type = "player",
        handle1x = -2,
        handle1y = -2,
        handle2x = 9,
        handle2y = 9,
    },
    par = {
        type = "par",
        value = 4
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 500,
        width = 300,
        height = 800,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1200,
        y = 500,
        width = 300,
        height = 800,
    },
}

level7 = {
    id = {
        type = "id",
        value = 7
    },
    playerinfo = {
        type = "player",
        handle1x = 9,
        handle1y = 890,
        handle2x = 30,
        handle2y = 860
    },
    par = {
        type = "par",
        value = 3
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    emp = {
        render = "circle",
        type = "emp",
        x = 700,
        y = 700,
        radius = 30,
        triggerRadius = 400
    },
    emp1 = {
        render = "circle",
        type = "emp",
        x = 300,
        y = 500,
        radius = 30,
        triggerRadius = 130
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 800,
        y = 900,
        width = 100,
        height = 300,
    },
}
--[[
  --- --
    ||
    ||
0 - -
]]--
level8 = {
    id = {
        type = "id",
        value = 8
    },
    playerinfo = {
        type = "player",
        handle1x = 9,
        handle1y = 890,
        handle2x = 30,
        handle2y = 860
    },
    par = {
        type = "par",
        value = 3
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    spike1 = {
        render = "rectangle",
        type = "spike",
        x = 500,
        y = 400,
        width = 100,
        height = 600,
    },
    top1 = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 100,
        width = 1100,
        height = 60,
    },
    top2 = {
        render = "rectangle",
        type = "wall",
        x = 1100,
        y = 500,
        width = 700,
        height = 800,
    },
    emp = {
        render = "circle",
        type = "emp",
        x = 600,
        y = 100,
        radius = 30,
        triggerRadius = 400
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1200,
        y = 75,
        width = 100,
        height = 100,
    },
}

--[[
0-0-0-|-0-0-0-0




]]--

level9 = {
    id = {
        type = "id",
        value = 9
    },
    playerinfo = {
        type = "player",
        handle1x = 130,
        handle1y = 880,
        handle2x = 600,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 13
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 600,
        y = 500,
        width = 10,
        height = 1000,
    },
    emp = {
        render = "circle",
        type = "emp",
        x = 620,
        y = 870,
        radius = 10,
        triggerRadius = 130,
        speed = 10000
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
        handle1x = -1000,
        handle1y = -100,
        handle2x = -1000,
        handle2y = -100
    },
    level1select = {
        render = "slice",
        image = "${levelImages[1]}",
        type = "button",
        sliceSize = 30,
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "1 par:" .. level1.par.value .. "\n best: ${levelScores[1]}",
        callback = function()
            levelLoadCallback(level1)
        end,
    },
    level2select = {
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "2 par:" .. level2.par.value .. "\n best: ${levelScores[2]}",
        callback = function()
            levelLoadCallback(level2)
        end,
    },
    level3select = {
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "3 par:" .. level3.par.value .. "\n best: ${levelScores[3]}",
        callback = function()
            levelLoadCallback(level3)
        end,
    },
    level4select = {
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "4 par:" .. level4.par.value .. "\n best: ${levelScores[4]}",
        callback = function()
            levelLoadCallback(level4)
        end,
    },
    level5select = {
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "5 par:" .. level5.par.value .. "\n best: ${levelScores[5]}",
        callback = function()
            levelLoadCallback(level5)
        end,
    },
    level6select = {
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "6 par:" .. level6.par.value .. "\n best: ${levelScores[6]}",
        callback = function()
            levelLoadCallback(level6)
        end,
    },
    level7select = {
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "7 par:" .. level7.par.value .. "\n best: ${levelScores[7]}",
        callback = function()
            levelLoadCallback(level7)
        end,
    },
    level8select = {
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "8 par:" .. level8.par.value .. "\n best: ${levelScores[8]}",
        callback = function()
            levelLoadCallback(level8)
        end,
    },
    level9select = {
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "9 par:" .. level9.par.value .. "\n best: ${levelScores[9]}",
        callback = function()
            levelLoadCallback(level9)
        end,
    },

}
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
    restart = {
        render = "slice",
        image = "uiOutline.png",
        sliceSize = 10,
        type = "button",
        x = (screenWidth / 2) - (screenWidth / 7),
        y = screenHeight / 1.3,
        w = (screenWidth / 3.5),
        h = screenHeight / 15,
        text = "Levels",
        callback = function()
            ui:clear()
            levelLoadCallback(levelselectionscreen)
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
    wall3 = {
        render = "rectangle",
        type = "wall",
        x = 600,
        y = 530,
        width = 100,
        height = 740,
    },
    pit = {
        render = "rectangle",
        type = "wall",
        x = 650, 
        y = 700,
        width = 1000,
        height = 400,
        body = nil,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1300,
        y = 400,
        width = 100,
        height = 1300,
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
level6 = {
    id = {
        type = "id",
        value = 6
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
        x = 900,
        y = 700,
        radius = 30,
        triggerRadius = 400
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 700,
        y = 600,
        width = 100,
        height = 700,
    },
    emp1 = {
        render = "circle",
        type = "emp",
        x = 300,
        y = 500,
        radius = 30,
        triggerRadius = 130
    },
    emp2 = {
        render = "circle",
        type = "emp",
        x = 500,
        y = 200,
        radius = 30,
        triggerRadius = 130
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1200,
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

level9 = {
    id = {
        type = "id",
        value = 9
    },
    playerinfo = {
        type = "player",
        handle1x = 130 + 600,
        handle1y = 880,
        handle2x = 600 + 600,
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
        x = 600+ 600,
        y = 500,
        width = 10,
        height = 950,
    },
    emp = {
        render = "circle",
        type = "emp",
        x = 620 + 600,
        y = 870,
        radius = 10,
        triggerRadius = 130,
        speed = 10000
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 15,
        y = 20,
        width = 20,
        height = 30,
    }
}

local levelsscreens = 3 - 1 -- has to have -1 because jank
levelselectionBar = {
    q1 = {
        render = "slice", 
        sliceSize = 1,
        image = "circlebutton.png",
        type = "button",
        x = ((screenWidth / (levelsscreens + 2)) * ((1) + 1)) - (screenWidth / (levelsscreens + 2)),
        y = screenHeight / 1.3,
        w = math.min(screenWidth / (levelsscreens + 2), 100),
        h = math.min(screenWidth / (levelsscreens + 2), 100),
        text = "1",
        callback = function()
            levelLoadCallback(levelselectionscreen)
        end,
    },
    q2 = {
        render = "slice", 
        sliceSize = 1,
        image = "circlebutton.png",
        type = "button",
        x = ((screenWidth / (levelsscreens + 2)) * ((2) + 1)) - (screenWidth / (levelsscreens + 2)),
        y = screenHeight / 1.3,
        w = math.min(screenWidth / (levelsscreens + 2), 100),
        h = math.min(screenWidth / (levelsscreens + 2), 100),
        text = "2",
        callback = function()
            levelLoadCallback(levelselectionscreen2)
        end,
    },
    q3 = {
        render = "slice", 
        sliceSize = 1,
        image = "circlebutton.png",
        type = "button",
        x = ((screenWidth / (levelsscreens + 2)) * ((3) + 1)) - (screenWidth / (levelsscreens + 2)),
        y = screenHeight / 1.3,
        w = math.min(screenWidth / (levelsscreens + 2), 100),
        h = math.min(screenWidth / (levelsscreens + 2), 100),
        text = "3",
        callback = function()
            levelLoadCallback(levelselectionscreen3)
        end,
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
        sliceSize = 30,
        type = "button",
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
        render = "slice",
        image = "${levelImages[2]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[3]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[4]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[5]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[6]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[7]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[8]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[9]}",
        sliceSize = 30,
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
    levelselectionBar.q1,
    levelselectionBar.q2,
    levelselectionBar.q3,

}
-- levels are all named the same because no time
levelselectionscreen2 = {
    playerinfo = {
        type = "player",
        handle1x = -1000,
        handle1y = -100,
        handle2x = -1000,
        handle2y = -100
    },
    level1select = {
        render = "slice",
        image = "${levelImages[10]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "10 par:" .. level1.par.value .. "\n best: ${levelScores[10]}", -- TODO; rhis
        callback = function()
            levelLoadCallback(level10)
        end,
    },
    level2select = {
        render = "slice",
        image = "${levelImages[11]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "11 par:" .. level2.par.value .. "\n best: ${levelScores[11]}",
        callback = function()
            levelLoadCallback(level11)
        end,
    },
    level3select = {
        render = "slice",
        image = "${levelImages[3]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[4]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[5]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[6]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[7]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[8]}",
        sliceSize = 30,
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
        render = "slice",
        image = "${levelImages[9]}",
        sliceSize = 30,
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
    levelselectionBar.q1,
    levelselectionBar.q2,
    levelselectionBar.q3,

}
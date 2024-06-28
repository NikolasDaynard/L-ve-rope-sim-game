require("level")

local screenWidth, screenHeight = love.window.getDesktopDimensions()

-- Spike object definition
local function levelLoadCallback(level)
    soundLib:playSound("sounds/clicklous.wav", settings.SFX)
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
settingsUi = {
    closeButton = {
        type = "button",
        render = "slice",
        image = "uiOutline.png",
        x = ((screenWidth / 2) - (screenWidth / 7)) - (screenWidth / 16),
        y = screenHeight / 7,
        w = (screenWidth / 16),
        h = screenHeight / 16,
        text = "X",
        callback = function()
            ui:remove(settingsUi)
        end,

    },
    textButton = {
        type = "button",
        render = "slice",
        image = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 7),
        y = screenHeight / 7,
        w = (screenWidth / 3.5),
        h = screenHeight / 2,
        text = "Level ${currentLevelId}\n\n\n\n\n\n",
        callback = function()
            -- ui:remove(settingsUi)
        end,
    },
    musicSlider = {
        type = "slider",
        barImage = "uiOutline.png",
        nubImage = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 10),
        y = screenHeight / 3.7,
        w = (screenWidth / 5),
        h = screenHeight / 20,
        text = "Volume",
        maxValue = 1,
        minValue = 0,
        value = "${settings.volume}",
        callback = function(value)
            settings.volume = value
            saveSettings()
        end,
    },
    musicVolSlider = {
        type = "slider",
        barImage = "uiOutline.png",
        nubImage = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 10),
        y = screenHeight / 3,
        w = (screenWidth / 5),
        h = screenHeight / 20,
        text = "Music Volume",
        maxValue = 1,
        minValue = 0,
        value = "${settings.musicVolume}",
        callback = function(value)
            settings.musicVolume = value
            saveSettings()
        end,
    },
    sfxVolSlider = {
        type = "slider",
        barImage = "uiOutline.png",
        nubImage = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 10),
        y = screenHeight / 2.5,
        w = (screenWidth / 5),
        h = screenHeight / 20,
        text = "SFX Volume",
        maxValue = 1,
        minValue = 0,
        value = "${settings.SFX}",
        callback = function(value)
            settings.SFX = value
            saveSettings()
        end,
    },
    fullscreenButton = {
        type = "slider",
        barImage = "uiOutline.png",
        nubImage = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 10),
        y = screenHeight / 2,
        w = (screenWidth / 5),
        h = screenHeight / 20,
        text = "Toggle fullscreen",
        maxValue = 1,
        minValue = 0,
        value = "${.5}",
        callback = function(value)
            print("fullscreen")
            if value > .5 then
                settings.fullscreen = true
            else
                settings.fullscreen = false
            end
            saveSettings()
            love.window.setFullscreen(settings.fullscreen)
            local w, h = love.graphics.getDimensions()
            love.resize(w, h)
        end,
    },
    openLevels = {
        type = "button",
        render = "slice",
        image = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 8),
        y = screenHeight / 1.3,
        w = (screenWidth / 4),
        h = screenHeight / 8,
        text = "Level Select",
        callback = function()
            levelLoadCallback(levelselectionscreen)
        end,
    },
    restart = {
        type = "button",
        render = "slice",
        image = "uiOutline.png",
        x = (screenWidth / 2) - (screenWidth / 8),
        y = screenHeight / 1.55,
        w = (screenWidth / 4),
        h = screenHeight / 8,
        text = "Restart",
        callback = function()
            ui:clear()
            local level = loadedLevel
            levelLoader:unloadLevel()
            levelLoader:loadLevel(level)
        end,
    }

}
--1.12, 1.3

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
        value = 5
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
        value = 5
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
        y = 50,
        width = 20,
        height = 100,
    }
}
--[[
   + +
   | |
   +-+
   like those cheap ring games
]]--
level10 = {
    id = {
        type = "id",
        value = 10
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
        value = 11
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
        height = 300,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 700,
        y = 645,
        width = 200,
        height = 10,
    },
    wall3 = {
        render = "rectangle",
        type = "wall",
        x = 800,
        y = 500,
        width = 10,
        height = 300,
    },
    wall4 = {
        render = "rectangle",
        type = "wall",
        x = 800,
        y = 500,
        width = 10,
        height = 300,
    },
    wall5 = {
        render = "rectangle",
        type = "wall",
        x = 900,
        y = 400,
        width = 400,
        height = 100,
        rotation = 50,
    },
    wall5spike = {
        render = "rectangle",
        type = "spike",
        x = 1100,
        y = 200,
        width = 400,
        height = 100,
        rotation = 50,
    },
    wall6 = {
        render = "rectangle",
        type = "wall",
        x = 500,
        y = 400,
        width = 400,
        height = 100,
        rotation = -50,
    },
    wall6spike = {
        render = "rectangle",
        type = "spike",
        x = 300,
        y = 200,
        width = 400,
        height = 100,
        rotation = -50,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 700,
        y = 635,
        width = 150,
        height = 10,
        rotation = 0,
    },
}
--[[   | 
    0   ->
     = |
]]--
level11 = {
    id = {
        type = "id",
        value = 11
    },
    playerinfo = {
        type = "player",
        handle1x = 40,
        handle1y = 880,
        handle2x = 50,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 11
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
        x = 500,
        y = 450,
        width = 400,
        height = 700,
        rotation = 0,
    },
    physicsZone = {
        render = "rectangle",
        type = "physics",
        x = 900,
        y = 400,
        width = 300,
        height = 500,
        rotation = 90,
    },
    physicsZone1 = {
        render = "rectangle",
        type = "physics",
        x = 1300,
        y = 400,
        width = 300,
        height = 500,
        rotation = 0,
    },
    physicsZone2 = {
        render = "rectangle",
        type = "physics",
        x = 1100,
        y = 600,
        width = 300,
        height = 500,
        rotation = -120,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 400,
        y = 0,
        width = 10,
        height = 200,
    },
    finishblock = {
        render = "rectangle",
        type = "physics",
        x = 335,
        y = 50,
        width = 100,
        height = 75,
        force = 10,
        rotation = -90
    },
}

--[[
    basically a bunch of physics zones try to push you into emps
]]--

level12 = {
    id = {
        type = "id",
        value = 12
    },
    playerinfo = {
        type = "player",
        handle1x = 40,
        handle1y = 780,
        handle2x = 50,
        handle2y = 780
    },
    par = {
        type = "par",
        value = 5
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    physicsZone = {
        render = "rectangle",
        type = "physics",
        x = 500,
        y = 400,
        width = 300,
        height = 200,
        rotation = 90,
    },
    physicsZone1 = {
        render = "rectangle",
        type = "physics",
        x = 700,
        y = 400,
        width = 300,
        height = 200,
        rotation = -90,
    },
    physicsZone2 = {
        render = "rectangle",
        type = "physics",
        x = 600,
        y = 200,
        width = 200,
        height = 400,
        rotation = -180,
    },
    physicsZone3 = {
        render = "rectangle",
        type = "physics",
        x = 600,
        y = 600,
        width = 200,
        height = 200,
        rotation = 180,
        force = -1
    },
    emp1 = {
        render = "circle",
        type = "emp",
        x = 600,
        y = 600,
        radius = 20,
        triggerRadius = 130,
    },
    emp2 = {
        render = "circle",
        type = "emp",
        x = 600,
        y = 500,
        radius = 20,
        triggerRadius = 130,
    },
    emp3 = {
        render = "circle",
        type = "emp",
        x = 600,
        y = 400,
        radius = 20,
        triggerRadius = 130,
    },
    emp4 = {
        render = "circle",
        type = "emp",
        x = 600,
        y = 300,
        radius = 20,
        triggerRadius = 130,
    },
    emp5 = {
        render = "circle",
        type = "emp",
        x = 700,
        y = 200,
        radius = 20,
        triggerRadius = 130,
    },
    spike = {
        render = "rectangle",
        type = "spike",
        x = 200,
        y = 200,
        width = 200,
        height = 400,
        triggerRadius = 130,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 600,
        y = 100,
        width = 20,
        height = 20,
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 200,
        y = 400,
        width = 400,
        height = 20,
        triggerRadius = 130,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 1100,
        y = 400,
        width = 700,
        height = 20,
        triggerRadius = 130,
    },
}
level13 = {
    id = {
        type = "id",
        value = 13
    },
    playerinfo = {
        type = "player",
        handle1x = 40,
        handle1y = 780,
        handle2x = 50,
        handle2y = 780
    },
    par = {
        type = "par",
        value = 23
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
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
        y = 500,
        width = 100,
        height = 800,
    },
    emp1 = {
        render = "cirle",
        type = "emp",
        x = 200,
        y = 100,
        radius = 10,
        triggerRadius = 200,
        speed = .5
    },
    emp2 = {
        render = "cirle",
        type = "emp",
        x = 600,
        y = 100,
        radius = 10,
        triggerRadius = 200,
        speed = .5
    },
    emp3 = {
        render = "cirle",
        type = "emp",
        x = 1000,
        y = 100,
        radius = 10,
        triggerRadius = 200,
        speed = .5
    },
    emp4 = {
        render = "cirle",
        type = "emp",
        x = 400,
        y = 700,
        radius = 10,
        triggerRadius = 200,
        speed = .5
    },
    emp5 = {
        render = "cirle",
        type = "emp",
        x = 800,
        y = 700,
        radius = 10,
        triggerRadius = 200,
        speed = .5
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 400,
        y = 300,
        width = 100,
        height = 800,
    },
    wall3 = {
        render = "rectangle",
        type = "wall",
        x = 600,
        y = 500,
        width = 100,
        height = 800,
    },
    wall4 = {
        render = "rectangle",
        type = "wall",
        x = 800,
        y = 300,
        width = 100,
        height = 800,
    },
    wall5 = {
        render = "rectangle",
        type = "wall",
        x = 1000,
        y = 500,
        width = 100,
        height = 800,
    },
    wall6 = {
        render = "rectangle",
        type = "wall",
        x = 1200,
        y = 300,
        width = 100,
        height = 800,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1400,
        y = 500,
        width = 100,
        height = 1000,
    },
}
level14 = {
    id = {
        type = "id",
        value = 14
    },
    playerinfo = {
        type = "player",
        handle1x = 40,
        handle1y = 200,
        handle2x = 50,
        handle2y = 200
    },
    par = {
        type = "par",
        value = 2
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 100,
        y = 500,
        width = 1000,
        height = 300,
        rotation = 45,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 1300,
        y = 500,
        width = 1000,
        height = 300,
        rotation = -45,
    },
    spring1 = {
        render = "rectangle",
        type = "spring",
        x = 400,
        y = 550,
        width = 70,
        height = 30,
        rotation = 45,
        force = 4,
    },
    spring2 = {
        render = "rectangle",
        type = "spring",
        x = 1000,
        y = 550,
        width = 70,
        height = 30,
        rotation = -45,
        force = 4,
    },
    spring3 = {
        render = "rectangle",
        type = "spring",
        x = 300,
        y = 450,
        width = 70,
        height = 30,
        rotation = 45,
        force = 3,
    },
    spring4 = {
        render = "rectangle",
        type = "spring",
        x = 1100,
        y = 450,
        width = 70,
        height = 30,
        rotation = -45,
        force = 3,
    },
    spring5 = {
        render = "rectangle",
        type = "spring",
        x = 200,
        y = 350,
        width = 70,
        height = 30,
        rotation = 45,
        force = 2,
    },
    spring6 = {
        render = "rectangle",
        type = "spring",
        x = 1200,
        y = 350,
        width = 70,
        height = 30,
        rotation = -45,
        force = 2,
    },
    spring7 = {
        render = "rectangle",
        type = "spring",
        x = 100,
        y = 250,
        width = 70,
        height = 30,
        rotation = 45,
        force = 2,
    },
    spring8 = {
        render = "rectangle",
        type = "spring",
        x = 1300,
        y = 250,
        width = 70,
        height = 30,
        rotation = -45,
        force = 2,
    },
    spike1 = {
        render = "rectangle",
        type = "spike",
        x = 500,
        y = 650,
        width = 300,
        height = 30,
        rotation = 45,
    },
    spike2 = {
        render = "rectangle",
        type = "spike",
        x = 900,
        y = 650,
        width = 300,
        height = 30,
        rotation = -45,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1440 / 2,
        y = 900,
        width = 700,
        height = 100,
    },
}
level15 = {
    id = {
        type = "id",
        value = 15
    },
    playerinfo = {
        type = "player",
        handle1x = 40,
        handle1y = 200,
        handle2x = 50,
        handle2y = 200
    },
    par = {
        type = "par",
        value = 4
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 100,
        y = 300,
        width = 1000,
        height = 300,
    },
    ground = {
        render = "rectangle",
        type = "spike",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 0,
        y = 675,
        width = 100,
        height = 450,
    },
}
-- 1 segment
level16 = {
    id = {
        type = "id",
        value = 16
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 880,
        handle2x = 300,
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
    emp = {
        render = "circle",
        type = "emp",
        x = 300,
        y = 880,
        radius = 20,
        triggerRadius = 250, 
        speed = 100000,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 350,
        y = 500,
        width = 10,
        height = 800,
    },
    physics = {
        render = "rectangle",
        type = "physics",
        x = 0,
        y = 500,
        width = 600,
        height = 800,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1300,
        y = 500,
        width = 100,
        height = 1000,
    },
}

level17 = {
    id = {
        type = "id",
        value = 17
    },
    playerinfo = {
        type = "player",
        handle1x = 300,
        handle1y = 880,
        handle2x = 300,
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
    spring1 = {
        render = "rectangle",
        type = "spring",
        x = 0,
        y = 300,
        width = 900,
        height = 100,
        force = 100,
        rotation = 90,
    },
    spring2 = {
        render = "rectangle",
        type = "spring",
        x = 1440,
        y = 300,
        width = 900,
        height = 100,
        force = 100,
        rotation = -90,
    },
    walls = {
        render = "rectangle",
        type = "wall",
        x = (1440 / 2) - 30,
        y = 0,
        width = 10,
        height = 120,
    },
    walls2 = {
        render = "rectangle",
        type = "wall",
        x = (1440 / 2) + 30,
        y = 0,
        width = 10,
        height = 120,
    },
    walls3 = {
        render = "rectangle",
        type = "wall",
        x = (1440 / 2),
        y = 700,
        width = 1000,
        height = 10,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1440 / 2,
        y = 0,
        width = 10,
        height = 100,
    },
}
level18 = {
    id = {
        type = "id",
        value = 18
    },
    playerinfo = {
        type = "player",
        handle1x = 10,
        handle1y = 880,
        handle2x = 50,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 12
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
        x = 300,
        y = 550,
        width = 100,
        height = 800,
    },
    physics = {
        render = "rectangle",
        type = "physics",
        x = 700,
        y = 200,
        width = 500,
        height = 200,
    },
    spike2 = {
        render = "rectangle",
        type = "spike",
        x = 1440,
        y = 550,
        width = 100,
        height = 800,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 700,
        y = 900,
        width = 400,
        height = 100,
    },
}
level19 = {
    id = {
        type = "id",
        value = 19
    },
    playerinfo = {
        type = "player",
        handle1x = 400,
        handle1y = 880,
        handle2x = 600,
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
    movingPlat = {
        render = "rectangle",
        type = "spring",
        x = 0,
        y = 700,
        width = 100,
        height = 25,
        update = function(levelTime)
            levelTime = levelTime * 3
            local posX = 400
            level19.movingPlat.x = (posX + (math.sin(levelTime)) * 100)
        end,
        rotation = -25,
        force = 100,
    },
    movingPlat2 = {
        render = "rectangle",
        type = "spring",
        x = 0,
        y = 700,
        width = 100,
        height = 25,
        update = function(levelTime)
            levelTime = levelTime * 3
            local posX = 700
            level19.movingPlat2.x = (posX + (math.sin(levelTime)) * 100)
        end,
        rotation = 25,
        force = 100,
    },
    spikes = {
        render = "rectangle",
        type = "spike",
        x = 0,
        y = 500,
        width = 100,
        height = 1000,
    },
    spikes2 = {
        render = "rectangle",
        type = "spike",
        x = 1400,
        y = 500,
        width = 100,
        height = 1000,
    },
    wall1 = {
        render = "rectangle",
        type = "wall",
        x = 200,
        y = 700,
        width = 350,
        height = 25,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 1000,
        y = 700,
        width = 500,
        height = 25,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 500,
        y = 15,
        width = 150,
        height = 30,
    },
}
level20 = {
    id = {
        type = "id",
        value = 20
    },
    playerinfo = {
        type = "player",
        handle1x = 400,
        handle1y = 880,
        handle2x = 600,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 5
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    finish = {
        render = "circle",
        type = "finish",
        x = 1440 / 2,
        y = 900 / 2,
        radius = 20,
        width = 20,
        height = 20,
    },
    spike = {
        render = "rectangle",
        type = "spike",
        x = (1440 / 2) + 200,
        y = 900 / 2,
        width = 20,
        height = 20,
        -- move circularly around (1440 / 2), 900 / 2
        update = function(levelTime)
            levelTime = levelTime * 3
            if level20.switch.enabled then
                levelTime = levelTime / 3
            end

            local centerX = 1440 / 2
            local centerY = 900 / 2

            local newX = centerX + math.cos(levelTime) * 100
            local newY = centerY + math.sin(levelTime) * 100
    
            level20.spike.x = newX
            level20.spike.y = newY
        end
    },
    spike2 = {
        render = "rectangle",
        type = "spike",
        x = (1440 / 2) + 200,
        y = 900 / 2,
        width = 20,
        height = 20,
        -- move circularly around (1440 / 2), 900 / 2
        update = function(levelTime)
            levelTime = levelTime * 4.5
            if level20.switch.enabled then
                levelTime = levelTime / 3
            end

            local centerX = 1440 / 2
            local centerY = 900 / 2

            local newX = centerX + math.cos(levelTime) * 100
            local newY = centerY + math.sin(levelTime) * 100
    
            level20.spike2.x = newX
            level20.spike2.y = newY
        end
    },
    spike3 = {
        render = "rectangle",
        type = "spike",
        x = (1440 / 2) + 200,
        y = 900 / 2,
        width = 20,
        height = 20,
        -- move circularly around (1440 / 2), 900 / 2
        update = function(levelTime)
            levelTime = levelTime * 5
            if level20.switch.enabled then
                levelTime = levelTime / 3
            end

            local centerX = 1440 / 2
            local centerY = 900 / 2

            local newX = centerX + math.cos(levelTime) * 100
            local newY = centerY + math.sin(levelTime) * 100
    
            level20.spike3.x = newX
            level20.spike3.y = newY
        end
    },
    spike4 = {
        render = "rectangle",
        type = "spike",
        x = (1440 / 2) + 200,
        y = 900 / 2,
        width = 20,
        height = 20,
        -- move circularly around (1440 / 2), 900 / 2
        update = function(levelTime)
            levelTime = levelTime * 6.02
            if level20.switch.enabled then
                levelTime = levelTime / 3
            end

            local centerX = 1440 / 2
            local centerY = 900 / 2

            local newX = centerX + math.cos(levelTime) * 100
            local newY = centerY + math.sin(levelTime) * 100
    
            level20.spike4.x = newX
            level20.spike4.y = newY
        end
    },
    spike5 = {
        render = "rectangle",
        type = "spike",
        x = (1440 / 2) + 200,
        y = 900 / 2,
        width = 20,
        height = 20,
        -- move circularly around (1440 / 2), 900 / 2
        update = function(levelTime)
            levelTime = levelTime * 7
            if level20.switch.enabled then
                levelTime = levelTime / 3
            end

            local centerX = 1440 / 2
            local centerY = 900 / 2

            local newX = centerX + math.cos(levelTime) * 100
            local newY = centerY + math.sin(levelTime) * 100
    
            level20.spike5.x = newX
            level20.spike5.y = newY
        end
    },
    spike6 = {
        render = "rectangle",
        type = "spike",
        x = (1440 / 2) + 200,
        y = 900 / 2,
        width = 20,
        height = 20,
        -- move circularly around (1440 / 2), 900 / 2
        update = function(levelTime)
            levelTime = levelTime * 8.33
            if level20.switch.enabled then
                levelTime = levelTime / 3
            end

            local centerX = 1440 / 2
            local centerY = 900 / 2

            local newX = centerX + math.cos(levelTime) * 100
            local newY = centerY + math.sin(levelTime) * 100
    
            level20.spike6.x = newX
            level20.spike6.y = newY
        end
    },
    switch = {
        render = "rectangle",
        type = "switch",
        x = 200,
        y = 600,
        width = 20,
        height = 50,
    }
}
level21 = {
    id = {
        type = "id",
        value = 21
    },
    playerinfo = {
        type = "player",
        handle1x = 710,
        handle1y = 330,
        handle2x = 700,
        handle2y = 300
    },
    par = {
        type = "par",
        value = 20
    },
    ground = {
        render = "rectangle",
        type = "spike",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    spinnywall = {
        render = "rectangle",
        type = "wall",
        x = 1440 / 2,
        y = 400,
        width = 300,
        height = 200,
        rotation = 0,
        update = function(levelTime, dt)
            level21.spinnywall.rotation = 0
            level21.spinnywall.rotation = level21.spinnywall.rotation + 300 * levelTime
        end,
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 200,
        y = 0,
        width = 10,
        height = 2000,
        rotation = 0,
        update = function(levelTime, dt)
            level21.wall.y = 0
            level21.wall.y = level21.wall.y + 300 * levelTime
        end,
    },
    blockerer = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 200,
        width = 400,
        height = 10,
        rotation = 0,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 0,
        y = 100,
        width = 100,
        height = 100,
        rotation = 0,
    },
}
level22 = {
    id = {
        type = "id",
        value = 22
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 880,
        handle2x = 50,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 20
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1440,
        y = 900,
        width = 100,
        height = 1000,
        update = function()
            level22.finish.y = 1100
            if level22.switch1.enabled == true then
                level22.finish.y = level22.finish.y - 50
            end
            if level22.switch2.enabled == true then
                level22.finish.y = level22.finish.y - 50
            end
            if level22.switch3.enabled == true then
                level22.finish.y = level22.finish.y - 50
            end
            if level22.switch4.enabled == true then
                level22.finish.y = level22.finish.y - 50
            end
            if level22.switch5.enabled == true then
                level22.finish.y = level22.finish.y - 50
            end
            if level22.switch6.enabled == true then
                level22.finish.y = level22.finish.y - 50
            end
        end
    },
    switch1 = {
        render = "rectangle",
        type = "switch",
        x = 200,
        y = 600,
        width = 20,
        height = 50,
    },
    switch2 = {
        render = "rectangle",
        type = "switch",
        x = 500,
        y = 700,
        width = 20,
        height = 50,
    },
    switch3 = {
        render = "rectangle",
        type = "switch",
        x = 1000,
        y = 300,
        width = 20,
        height = 50,
    },
    switch4 = {
        render = "rectangle",
        type = "switch",
        x = 500,
        y = 200,
        width = 20,
        height = 50,
    },
    switch5 = {
        render = "rectangle",
        type = "switch",
        x = 550,
        y = 500,
        width = 20,
        height = 50,
    },
    switch6 = {
        render = "rectangle",
        type = "switch",
        x = 700,
        y = 300,
        width = 20,
        height = 50,
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 1440,
        y = 350,
        width = 200,
        height = 20,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 1350,
        y = 700,
        width = 10,
        height = 800,
    },
}
level23 = {
    id = {
        type = "id",
        value = 23
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 880,
        handle2x = 50,
        handle2y = 880
    },
    par = {
        type = "par",
        value = 8
    },
    ground = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 300,
        y = 500,
        width = 10,
        height = 1000,
        update = function(levelTime)
            level23.finish.x = 300
            level23.finish.x = level23.finish.x + 200 * levelTime
        end
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 200,
        y = 500,
        width = 100,
        height = 800,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 400,
        y = 300,
        width = 100,
        height = 800,
    },
    switch = {
        render = "rectangle",
        type = "switch",
        x = 500,
        y = 300,
        width = 100,
        height = 100,
    },
    spike = {
        render = "rectangle",
        type = "spike",
        x = 1900,
        y = 990,
        width = 3200,
        height = 25,
        update = function(levelTime)
            if level23.switch.enabled then
                level23.spike.y = 880
            else
                level23.spike.y = 990
            end
        end
    },
}
level24 = {
    id = {
        type = "id",
        value = 24
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 140,
        handle2x = 50,
        handle2y = 140
    },
    par = {
        type = "par",
        value = 11
    },
    ground = {
        render = "rectangle",
        type = "spike",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
        update = function(levelTime) 
            level24.ground.y = 900
            level24.ground.y = level24.ground.y - 100 * levelTime
        end
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 0,
        y = 550,
        width = 300,
        height = 750,
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 500,
        y = 550,
        width = 300,
        height = 750,
    },
    wall3 = {
        render = "rectangle",
        type = "wall",
        x = 1000,
        y = 550,
        width = 300,
        height = 750,
    },
    switch1 = {
        render = "rectangle",
        type = "switch",
        x = 300,
        y = 750,
        width = 300,
        height = 200,
        update = function()
            if level24.switch1.enabled then
                level24.switch1.x = -1000
            else
                level24.switch1.x = 300
            end
        end
    },
    switch2 = {
        render = "rectangle",
        type = "switch",
        x = 700,
        y = 450,
        width = 300,
        height = 200,
        update = function()
            if level24.switch2.enabled then
                level24.switch2.x = -1000
            else
                level24.switch2.x = 700
            end
        end
    },
    finishblock = {
        render = "rectangle",
        type = "wall",
        x = 1440,
        y = 200,
        width = 600,
        height = 20,
        update = function()
            if level24.switch1.enabled and level24.switch2.enabled then
                level24.finishblock.x = -1000
            else
                level24.finishblock.x = 1440
            end
        end
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1440,
        y = 350,
        width = 600,
        height = 200,
    },
}
level25 = {
    id = {
        type = "id",
        value = 25
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 140,
        handle2x = 50,
        handle2y = 140
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
    spring = {
        render = "rectangle",
        type = "spring",
        x = 400,
        y = 500,
        width = 200,
        height = 20,
        rotation = 30,
        force = 100,
        update = function(levelTime) 
            level25.spring.rotation = 0
            level25.spring.rotation = levelTime * 300
        end
    },
    spring1 = {
        render = "rectangle",
        type = "spring",
        x = 900,
        y = 800,
        width = 200,
        height = 20,
        rotation = 30,
        force = 100,
        update = function(levelTime) 
            level25.spring1.rotation = 0
            level25.spring1.rotation = levelTime * 122
        end
    },
    spring2 = {
        render = "rectangle",
        type = "spring",
        x = 700,
        y = 300,
        width = 200,
        height = 20,
        rotation = 30,
        force = 100,
        update = function(levelTime) 
            level25.spring2.rotation = 0
            level25.spring2.rotation = levelTime * 270
        end
    },
    spring3 = {
        render = "rectangle",
        type = "spring",
        x = 900,
        y = 200,
        width = 200,
        height = 20,
        rotation = 30,
        force = 100,
        update = function(levelTime) 
            level25.spring3.rotation = 0
            level25.spring3.rotation = levelTime * 312
        end
    },
    finish = {
        render = "rectangle",
        type = "finish",
        x = 1440 / 2,
        y = 20,
        width = 200,
        height = 20,
    },
    finishwalls = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2 + 200,
        y = 20,
        width = 200,
        height = 20,
    },
    finishwalls2 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2 - 200,
        y = 20,
        width = 200,
        height = 20,
    },
}
--[[
  /
 /
/
]]--
level26 = {
    id = {
        type = "id",
        value = 26
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 140,
        handle2x = 50,
        handle2y = 140
    },
    par = {
        type = "par",
        value = 5
    },
    ground = {
        render = "rectangle",
        type = "finish",
        x = 0,
        y = 900,
        width = 3200,
        height = 25,
    },
    wall = {
        render = "rectangle",
        type = "wall",
        x = 230,
        y = 500,
        width = 500,
        height = 10,
        rotation = -30
    },
    wall2 = {
        render = "rectangle",
        type = "wall",
        x = 1230,
        y = 500,
        width = 500,
        height = 10,
        rotation = 30
    },
    spike1 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2,
        y = 400,
        width = 20,
        height = 10,
        update = function(levelTime)
            levelTime = levelTime * 2
            level26.spike1.x = 1440 / 2
            level26.spike1.x = level26.spike1.x + 290 * math.sin(levelTime)
        end
    },
    spike2 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2,
        y = 400,
        width = 20,
        height = 10,
        update = function(levelTime)
            levelTime = levelTime * 2.3
            level26.spike2.x = 1440 / 2
            level26.spike2.x = level26.spike2.x + 290 * math.sin(levelTime)
        end
    },
    spike3 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2,
        y = 400,
        width = 40,
        height = 10,
        update = function(levelTime)
            levelTime = levelTime * 2.5
            level26.spike3.x = 1440 / 2
            level26.spike3.x = level26.spike3.x + 290 * math.sin(levelTime)
        end
    },
    spike4 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2,
        y = 400,
        width = 40,
        height = 10,
        update = function(levelTime)
            levelTime = -levelTime * 9.1
            level26.spike4.x = 1440 / 2
            level26.spike4.x = level26.spike4.x + 290 * math.sin(levelTime)
        end
    },
    spike5 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2,
        y = 400,
        width = 40,
        height = 10,
        update = function(levelTime)
            levelTime = -levelTime * 3.21231
            level26.spike5.x = 1440 / 2
            level26.spike5.x = level26.spike5.x + 290 * math.sin(levelTime)
        end
    },
    spike6 = {
        render = "rectangle",
        type = "spike",
        x = 1440 / 2,
        y = 400,
        width = 40,
        height = 10,
        update = function(levelTime)
            levelTime = levelTime * 3.829
            level26.spike6.x = 1440 / 2
            level26.spike6.x = level26.spike6.x + 290 * math.sin(levelTime)
        end
    },
}
level27 = {
    id = {
        type = "id",
        value = 27
    },
    playerinfo = {
        type = "player",
        handle1x = 20,
        handle1y = 140,
        handle2x = 50,
        handle2y = 140
    },
    par = {
        type = "par",
        value = 8
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
        type = "spike",
        x = 600,
        y = 900,
        width = 300,
        height = 600,
    },
    wall2 = {
        render = "rectangle",
        type = "spike",
        x = 600,
        y = 100,
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

local levelsscreens = 3 - 1 -- has to have -1 because jank
levelselectionBar = {
    q1 = {
        render = "slice", 
        sliceSize = 0,
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
        sliceSize = 0,
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
        sliceSize = 0,
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
        text = "10 par:" .. level10.par.value .. "\n best: ${levelScores[10]}", -- TODO; rhis
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
        text = "11 par:" .. level11.par.value .. "\n best: ${levelScores[11]}",
        callback = function()
            levelLoadCallback(level11)
        end,
    },
    level3select = {
        render = "slice",
        image = "${levelImages[12]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "12 par:" .. level12.par.value .. "\n best: ${levelScores[12]}",
        callback = function()
            levelLoadCallback(level12)
        end,
    },
    level4select = {
        render = "slice",
        image = "${levelImages[13]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "13 par:" .. level13.par.value .. "\n best: ${levelScores[13]}",
        callback = function()
            levelLoadCallback(level13)
        end,
    },
    level5select = {
        render = "slice",
        image = "${levelImages[14]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "14 par:" .. level14.par.value .. "\n best: ${levelScores[14]}",
        callback = function()
            levelLoadCallback(level14)
        end,
    },
    level6select = {
        render = "slice",
        image = "${levelImages[15]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "15 par:" .. level15.par.value .. "\n best: ${levelScores[15]}",
        callback = function()
            levelLoadCallback(level15)
        end,
    },
    level7select = {
        render = "slice",
        image = "${levelImages[16]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "16 par:" .. level16.par.value .. "\n best: ${levelScores[16]}",
        callback = function()
            levelLoadCallback(level16)
        end,
    },
    level17select = {
        render = "slice",
        image = "${levelImages[17]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "17 par:" .. level17.par.value .. "\n best: ${levelScores[17]}",
        callback = function()
            levelLoadCallback(level17)
        end,
    },
    level18select = {
        render = "slice",
        image = "${levelImages[18]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "18 par:" .. level18.par.value .. "\n best: ${levelScores[18]}",
        callback = function()
            levelLoadCallback(level18)
        end,
    },
    levelselectionBar.q1,
    levelselectionBar.q2,
    levelselectionBar.q3,

}
-- LETS GO WE NEEDED ANOTHER
levelselectionscreen3 = {
    playerinfo = {
        type = "player",
        handle1x = -1000,
        handle1y = -100,
        handle2x = -1000,
        handle2y = -100
    },
    level1select = {
        render = "slice",
        image = "${levelImages[19]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "19 par:" .. level19.par.value .. "\n best: ${levelScores[19]}", -- TODO; rhis
        callback = function()
            levelLoadCallback(level19)
        end,
    },
    level2select = {
        render = "slice",
        image = "${levelImages[20]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "20 par:" .. level20.par.value .. "\n best: ${levelScores[20]}",
        callback = function()
            levelLoadCallback(level20)
        end,
    },
    level3select = {
        render = "slice",
        image = "${levelImages[21]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 3,
        w = screenWidth / 7,
        h = 60,
        text = "21 par:" .. level21.par.value .. "\n best: ${levelScores[21]}",
        callback = function()
            levelLoadCallback(level21)
        end,
    },
    level4select = {
        render = "slice",
        image = "${levelImages[22]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "22 par:" .. level22.par.value .. "\n best: ${levelScores[22]}",
        callback = function()
            levelLoadCallback(level22)
        end,
    },
    level5select = {
        render = "slice",
        image = "${levelImages[23]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "23 par:" .. level23.par.value .. "\n best: ${levelScores[23]}",
        callback = function()
            levelLoadCallback(level23)
        end,
    },
    level6select = {
        render = "slice",
        image = "${levelImages[24]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 2,
        w = screenWidth / 7,
        h = 60,
        text = "24 par:" .. level24.par.value .. "\n best: ${levelScores[24]}",
        callback = function()
            levelLoadCallback(level24)
        end,
    },
    level7select = {
        render = "slice",
        image = "${levelImages[25]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 2) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "25 par:" .. level25.par.value .. "\n best: ${levelScores[25]}",
        callback = function()
            levelLoadCallback(level25)
        end,
    },
    level17select = {
        render = "slice",
        image = "${levelImages[26]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 3) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "26 par:" .. level26.par.value .. "\n best: ${levelScores[26]}",
        callback = function()
            levelLoadCallback(level26)
        end,
    },
    level27select = {
        render = "slice",
        image = "${levelImages[27]}",
        sliceSize = 30,
        type = "button",
        x = ((screenWidth / 5) * 4) - (screenWidth / 7),
        y = screenHeight / 1.5,
        w = screenWidth / 7,
        h = 60,
        text = "27 par:" .. level27.par.value .. "\n best: ${levelScores[27]}",
        callback = function()
            levelLoadCallback(level27)
        end,
    },
    levelselectionBar.q1,
    levelselectionBar.q2,
    levelselectionBar.q3,

}
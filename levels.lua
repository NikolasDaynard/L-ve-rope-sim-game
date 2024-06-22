-- Spike object definition
menu = {
    button = {
        type = "button",
        x = 400,
        y = 400,
        w = 50,
        h = 20,
    }
}

level1 = {
playerinfo = {
    type = "player",
    handle1x = 90,
    handle1y = 90,
    handle2x = 300,
    handle2y = 300
},
spike = {
    render = "rectangle",
    type = "spike",
    x = 500, 
    y = 200, 
    width = 50,
    height = 50,
    body = nil,
},
spike2 = {
    render = "rectangle",
    type = "spike",
    x = 400, 
    y = 400, 
    width = 50,
    height = 50,
    body = nil,
}
}
-- Spike object definition
level2 = {
    playerinfo = {
        type = "player",
        handle1x = 90,
        handle1y = 90,
        handle2x = 300,
        handle2y = 300
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
    wall = {
        render = "rectangle",
        type = "spike",
        x = 1500, 
        y = 900, 
        width = 50,
        height = 50,
        body = nil,
    }
}
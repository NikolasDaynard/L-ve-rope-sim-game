ui = {
    buttons = {},
    buttonNum = 0,
}

function ui:addButton(x, y, w, h, callback)
    buttons[buttonNum] = {x, y, w, h, callback}
    buttonNum = buttonNum + 1
end
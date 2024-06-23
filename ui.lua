ui = {
    buttons = {},
    buttonNum = 1,
}

function ui:addButton(x, y, w, h, callback)
    self.buttons[self.buttonNum] = {x = x, y = y, w = w, h = h, callback = callback}
    self.buttonNum = self.buttonNum + 1
end

function ui:update(mousePos) 
    for i = 1, self.buttonNum - 1 do
        if mousePos.x >= self.buttons[i].x and mousePos.x <= self.buttons[i].x + self.buttons[i].w and mousePos.y >= self.buttons[i].y and mousePos.y <= self.buttons[i].y + self.buttons[i].h then
            if love.mouse.isDown(1) then
                self.buttons[i].callback()
            end
        end
    end
end
function ui:render() 
    for i = 1, self.buttonNum - 1 do
        love.graphics.rectangle("fill", self.buttons[i].x, self.buttons[i].y, self.buttons[i].w, self.buttons[i].h)
    end
end

function ui:clear()
    for i = 1, self.buttonNum - 1 do
        self.buttons[self.buttonNum] = nil
    end
    self.buttonNum = 1
end
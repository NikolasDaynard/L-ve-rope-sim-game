ui = {
    buttons = {},
    buttonNum = 1,
    clicking = false
}

function ui:addButton(x, y, w, h, callback, text)
    self.buttons[self.buttonNum] = {x = x, y = y, w = w, h = h, text = text, callback = callback}
    self.buttonNum = self.buttonNum + 1
end

function ui:update(mousePos)
    local mouseDown = love.mouse.isDown(1)

    for i = 1, self.buttonNum - 1 do
        if mousePos.x >= self.buttons[i].x and mousePos.x <= self.buttons[i].x + self.buttons[i].w and mousePos.y >= self.buttons[i].y and mousePos.y <= self.buttons[i].y + self.buttons[i].h then
            if mouseDown and not self.clicking then
                self.buttons[i].callback()
                self.clicking = true
            end
        end
    end

    if not mouseDown then
        self.clicking = false
    end
end
function ui:render()
    for i = 1, self.buttonNum - 1 do
        love.graphics.setColor(1, 1, 1) 
        love.graphics.rectangle("fill", self.buttons[i].x, self.buttons[i].y, self.buttons[i].w, self.buttons[i].h)
        
        if self.buttons[i].text ~= nil then
            love.graphics.setColor(0, 0, 0)

            local textWidth = love.graphics.getFont():getWidth(self.buttons[i].text)
            local textHeight = love.graphics.getFont():getHeight(self.buttons[i].text)
            local textX = self.buttons[i].x + (self.buttons[i].w / 2) - (textWidth / 2)
            local textY = self.buttons[i].y + (self.buttons[i].h / 2) - (textHeight / 2)
            
            love.graphics.print(self.buttons[i].text, textX, textY)
            
            love.graphics.setColor(1, 1, 1)
        end
    end
end


function ui:clear()
    for i = 1, self.buttonNum - 1 do
        self.buttons[self.buttonNum] = nil
    end
    self.buttonNum = 1
    ui.clicking = false
end
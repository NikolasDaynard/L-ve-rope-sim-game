ui = {
    buttons = {},
    buttonNum = 1,
    clicking = false
}

function ui:addButton(x, y, w, h, callback, text, image, type, sliceSize)
    if image ~= nil then
        if type == "slice" then
            imageLib:loadSlicesImage(image, sliceSize)
        else
            imageLib:loadImage(image)
        end
        self.buttons[self.buttonNum] = {x = x, y = y, w = w, h = h, text = text, callback = callback, image = image}
    else
        self.buttons[self.buttonNum] = {x = x, y = y, w = w, h = h, text = text, callback = callback}
    end
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
        if self.buttons[i].image ~= nil then
            imageLib:render(self.buttons[i].image, self.buttons[i].x, self.buttons[i].y, self.buttons[i].w, self.buttons[i].h)
        else
            love.graphics.setColor(1, 1, 1) 
            love.graphics.rectangle("fill", self.buttons[i].x, self.buttons[i].y, self.buttons[i].w, self.buttons[i].h)
        end
        
        if self.buttons[i].text ~= nil then
            -- add variables to the string
            self.buttons[i].text = interpolate(self.buttons[i].text)
            love.graphics.setColor(0, 0, 0)

            local textLines = splitString(self.buttons[i].text, "\n")

            for j, line in ipairs(textLines) do
                local textWidth = love.graphics.getFont():getWidth(self.buttons[i].text)
                local textHeight = love.graphics.getFont():getHeight(self.buttons[i].text)
                local textX = self.buttons[i].x + (self.buttons[i].w / 2) - (textWidth / 2)
                local textY = self.buttons[i].y + (self.buttons[i].h / (#textLines + 1)) - (textHeight / (#textLines + 1))
                
                love.graphics.print(self.buttons[i].text, textX, textY)
            end
            
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

function ui:remove(uiToRemove) 
    local newUiTable = {}
    local newButtonNum = 1
    for key, value in pairs(uiToRemove) do
        for i = self.buttonNum - 1, 1, -1 do 
            print(value.text)
            print(self.buttons[i].text)
            if self.buttons[i].text ~= value.text then
                newUiTable[newButtonNum] = self.buttons[i]
                newButtonNum = newButtonNum + 1
            end
        end
        self.buttons = newUiTable
        self.buttonNum = newButtonNum
        newButtonNum = 1
        newUiTable = {}
    end
end

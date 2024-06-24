ui = {
    buttons = {},
    buttonNum = 1,
    sliders = {},
    sliderNum = 1,
    clicking = false,
    sliderHeldId = nil
}

function ui:doesButtonExist(text) 
    for i = 1, self.buttonNum - 1 do
        if self.buttons[i].text == text then
            return true
        end
    end
    return false
end

function ui:addButton(x, y, w, h, callback, text, image, type, sliceSize)
    if ui:doesButtonExist(interpolate(doesButtonExist)) then
        return
    end

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

function ui:addSlider(x, y, w, h, callback, text, minValue, maxValue, value, barImage, nubImage, render, sliceSize)
    value = interpolate(value)
    self.sliders[self.sliderNum] = {x = x, y = y, w = w, h = h, text = text, callback = callback, minValue = minValue, maxValue = maxValue, sliderPos = value}
    if barImage ~= nil then
        self.sliders[self.sliderNum].barImage = barImage
        imageLib:loadImage(barImage)
    end
    if nubImage ~= nil then
        self.sliders[self.sliderNum].nubImage = nubImage
        imageLib:loadImage(nubImage)
    end

    self.sliderNum = self.sliderNum + 1
end

function ui:update(mousePos)
    local mouseDown = love.mouse.isDown(1)
    local hitSlider = false

    if self.clicking and not mouseDown and self.sliderHeldId ~= nil then
        self.sliders[self.sliderHeldId].callback(self.sliders[self.sliderHeldId].sliderPos)
    end

    if mouseDown and self.clicking and self.sliderHeldId ~= nil then
        self.sliders[self.sliderHeldId].sliderPos = (math.min(math.max(-((1 - ((mousePos.x + self.sliders[self.sliderHeldId].w) - (self.sliders[self.sliderHeldId].x + self.sliders[self.sliderHeldId].w)) / self.sliders[self.sliderHeldId].w) - 1), 0), 1))
        -- trigger callback on release
    else
        self.sliderHeldId = nil
        for i = 1, self.sliderNum - 1 do
            if self.sliders[i] ~= nil then
                if mousePos.x >= self.sliders[i].x and mousePos.x <= self.sliders[i].x + self.sliders[i].w and mousePos.y >= self.sliders[i].y and mousePos.y <= self.sliders[i].y + self.sliders[i].h then
                    if mouseDown and not self.clicking then
                        self.clicking = true
                        hitSlider = true
                        self.sliderHeldId = i
                    end
                end
            end
        end
    end

    if not hitSlider then
        for i = 1, self.buttonNum - 1 do
            -- I don't want to but
            if self.buttons[i] ~= nil then
                if mousePos.x >= self.buttons[i].x and mousePos.x <= self.buttons[i].x + self.buttons[i].w and mousePos.y >= self.buttons[i].y and mousePos.y <= self.buttons[i].y + self.buttons[i].h then
                    if mouseDown and not self.clicking then
                        self.buttons[i].callback()
                        self.clicking = true
                    end
                end
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
    for i = 1, self.sliderNum - 1 do
        if self.sliders[i].barImage ~= nil then
            imageLib:render(self.sliders[i].barImage, self.sliders[i].x, self.sliders[i].y, self.sliders[i].w, self.sliders[i].h)
        else
            love.graphics.setColor(1, .1, 1)
            love.graphics.rectangle("fill", self.sliders[i].x, self.sliders[i].y, self.sliders[i].w, self.sliders[i].h)
        end

        if self.sliders[i].nubImage ~= nil then
            imageLib:render(self.sliders[i].nubImage, self.sliders[i].x + (self.sliders[i].w * self.sliders[i].sliderPos) - ((self.sliders[i].h * 1.2) / 2), self.sliders[i].y - ((self.sliders[i].h * .2) / 2), self.sliders[i].h * 1.2, self.sliders[i].h * 1.2)
        else
            love.graphics.rectangle("fill", self.sliders[i].x + (self.sliders[i].w * self.sliders[i].sliderPos) - ((self.sliders[i].h * 1.2) / 2), self.sliders[i].y - ((self.sliders[i].h * .2) / 2), self.sliders[i].h * 1.2, self.sliders[i].h * 1.2)
        end
        love.graphics.setColor(1, 1, 1)
        if self.sliders[i].text ~= nil then
            -- add variables to the string
            self.sliders[i].text = interpolate(self.sliders[i].text)
            love.graphics.setColor(0, 0, 0)

            local textLines = splitString(self.sliders[i].text, "\n")

            for j, line in ipairs(textLines) do
                local textWidth = love.graphics.getFont():getWidth(self.sliders[i].text)
                local textHeight = love.graphics.getFont():getHeight(self.sliders[i].text)
                local textX = self.sliders[i].x + (self.sliders[i].w / 2) - (textWidth / 2)
                local textY = self.sliders[i].y + (self.sliders[i].h / (#textLines + 1)) - (textHeight / (#textLines + 1))
                
                love.graphics.print(self.sliders[i].text, textX, textY)
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
    for i = 1, self.sliderNum - 1 do
        self.sliders[self.sliderNum] = nil
    end
    self.sliderNum = 1
    ui.clicking = false
end

function ui:remove(uiToRemove) 
    local newUiTable = {}
    local newButtonNum = 1
    local toRemoveSet = {}

    -- Create a set of texts to remove for faster lookup
    for key, value in pairs(uiToRemove) do
        toRemoveSet[interpolate(value.text)] = true
    end

    -- Iterate over existing buttons and copy those not in the removal set
    for i = 1, self.buttonNum - 1 do
        if not toRemoveSet[self.buttons[i].text] then
            newUiTable[newButtonNum] = self.buttons[i]
            newButtonNum = newButtonNum + 1
        end
    end

    -- Update the buttons and button count
    self.buttons = newUiTable
    self.buttonNum = newButtonNum

    -- sliders
    newUiTable = {}
    local newSliderNum = 1
    toRemoveSet = {}

    -- Create a set of texts to remove for faster lookup
    for key, value in pairs(uiToRemove) do
        toRemoveSet[interpolate(value.text)] = true
    end

    -- Iterate over existing buttons and copy those not in the removal set
    for i = 1, self.sliderNum - 1 do
        if not toRemoveSet[self.sliders[i].text] then
            newUiTable[newSliderNum] = self.sliders[i]
            newSliderNum = newSliderNum + 1
        end
    end

    -- Update the buttons and button count
    self.sliders = newUiTable
    self.sliderNum = newSliderNum
end

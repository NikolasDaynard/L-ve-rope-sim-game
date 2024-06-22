momentumArrow = {
    x = 0,
    y = 0,
    endXPoint = 0,
    endYPoint = 0,
    draggingForce = 300,
    visible = false,
}

function momentumArrow:render() 
    if visible then
        love.graphics.rectangle("fill", self.x, self.y, 10, 10)
        love.graphics.rectangle("fill", self.endXPoint, self.endYPoint, 10, 10)
    end
end

function momentumArrow:setOrigin(x, y) 
    self.x = x
    self.y = y
end
function momentumArrow:setPosition(x, y) 
    -- emulate force required to draw back
    dist = math.sqrt(distance(x, y, self.x, self.y))
    translationX = (x - self.x) * dist
    translationY = (y - self.y) * dist
    translationX = translationX / 50
    translationY = translationY / 50
    self.endXPoint = self.x + translationX
    self.endYPoint = self.y + translationY
end

function momentumArrow:getForce() 
    return {x = (self.endXPoint - self.x) * self.draggingForce, y = (self.endYPoint - self.y) * self.draggingForce}
end

function momentumArrow:hide() 
    visible = false
end
function momentumArrow:show() 
    visible = true
end
momentumArrow = {
    x = 0,
    y = 0,
    endXPoint = 0,
    endYPoint = 0,
    draggingForce = 300,
    visible = false,
}

function momentumArrow:rotateTriangle()
    local arrowverts  = {0, 0, 100, 0, 100, 100, 150, 75, 50, 200, -50, 75, 0, 100} -- Arrow shape vertices

    -- 200 is the tip so take the dist between end and start and multiply by scale

    -- local scale = 

    -- arrow is 90 off
    local angle = math.atan2(self.endYPoint - self.y, self.endXPoint - self.x) - math.rad(90)
    
    -- rotate around 0,0
    local function rotate(x, y, angle)
        local cosTheta = math.cos(angle)
        local sinTheta = math.sin(angle)
        return x * cosTheta - y * sinTheta, x * sinTheta + y * cosTheta
    end
    
    local rotatedVerts = {}
    for i = 1, #arrowverts, 2 do
        -- the -50 centers the arrow
        local x, y = rotate(arrowverts[i] - 50, arrowverts[i + 1], angle)
        table.insert(rotatedVerts, x + self.x)
        table.insert(rotatedVerts, y + self.y)
    end

    local triangles = love.math.triangulate(rotatedVerts)
    for i, triangle in ipairs(triangles) do
        love.graphics.polygon("fill", triangle)
    end
end

function momentumArrow:render() 
    if visible then
        love.graphics.rectangle("fill", self.x, self.y, 10, 10)
        love.graphics.rectangle("fill", self.endXPoint, self.endYPoint, 10, 10)
        momentumArrow:rotateTriangle(self.x, self.y, self.endXPoint, self.endYPoint)
    end
end

function momentumArrow:setOrigin(x, y) 
    self.x = x
    self.y = y
end
function momentumArrow:setPosition(x, y) 
    -- emulate force required to draw back
    dist = math.sqrt(distance(x, y, self.x, self.y))
    translationX = (x - self.x) / dist
    translationY = (y - self.y) / dist
    translationX = translationX * 7
    translationY = translationY * 7
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
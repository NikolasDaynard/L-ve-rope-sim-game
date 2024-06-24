-- thank you goodle

image = {
    images = {},
    slices = {}
}

function image:loadImage(imageName) 
    self.images[imageName] = love.graphics.newImage(imageName)
    self.images[imageName]:setFilter("nearest", "nearest")
end
function image:loadSlicesImage(imageName) 
    image:loadImage(imageName)
    image:slice(imageName)
end

-- creates a 9 way slice, good for pixel art ui
function image:slice(imageName) 
    local sliceSize = 10 -- Size of the corners and edges, 10 seems to work good
    local imageWidth, imageHeight = self.images[imageName]:getDimensions()

    local imageSlices = {
        {0, 0, sliceSize, sliceSize}, -- top left corner
        {sliceSize, 0, imageWidth - 2 * sliceSize, sliceSize}, -- top edge
        {imageWidth - sliceSize, 0, sliceSize, sliceSize}, -- top right corner

        {0, sliceSize, sliceSize, imageHeight - 2 * sliceSize}, -- left edge
        {sliceSize, sliceSize, imageWidth - 2 * sliceSize, imageHeight - 2 * sliceSize}, -- center
        {imageWidth - sliceSize, sliceSize, sliceSize, imageHeight - 2 * sliceSize}, -- right edge

        {0, imageHeight - sliceSize, sliceSize, sliceSize}, -- bottom left corner
        {sliceSize, imageHeight - sliceSize, imageWidth - 2 * sliceSize, sliceSize}, -- bottom edge
        {imageWidth - sliceSize, imageHeight - sliceSize, sliceSize, sliceSize}, -- bottom right
    }

    self.slices[imageName] = imageSlices
end

function image:render(imageName, x, y, scaleX, scaleY)
    scaleX = scaleX or 1
    scaleY = scaleY or 1

    if self.images[imageName] ~= nil then
        if self.slices[imageName] == nil then
            love.graphics.draw(self.images[imageName], x, y, 0, scaleX, scaleY)
        else
            local imageWidth, imageHeight = self.images[imageName]:getDimensions()
            image:renderSlices(imageName, self.slices[imageName], x, y, scaleX * imageWidth, scaleY * imageHeight)
            print("slices")
        end
    else
        print(imageName)
        print("twas nil")
    end
end

function image:renderSlices(imageName, slices,x, y, targetWidth, targetHeight)
    local imageWidth, imageHeight = self.images[imageName]:getDimensions()
    local scaleX, scaleY
    local sliceSize = 10
    local slices = self.slices[imageName] -- hard to write makes me sad

    for i, slice in ipairs(slices) do
        local sx, sy, sw, sh = unpack(slice)

        if i == 2 or i == 8 then
            -- Top and bottom edges horizontally
            scaleX = (targetWidth - 2 * sliceSize) / sw
            scaleY = 1
        elseif i == 4 or i == 6 then
            -- Left and right edges vertically
            scaleX = 1
            scaleY = (targetHeight - 2 * sliceSize) / sh
        elseif i == 5 then
            -- Center horizontal + vertical
            scaleX = (targetWidth - 2 * sliceSize) / sw
            scaleY = (targetHeight - 2 * sliceSize) / sh
        else
            -- Corners
            scaleX = 1
            scaleY = 1
        end

        -- Determine the draw position
        local dx
        if i == 2 or i == 5 or i == 8 then
            dx = x + (sliceSize + (targetWidth - 2 * sliceSize)) * ((i - 1) % 3)
        else
            dx = x + 0
        end
        local dy
        if i >= 4 and i <= 6 then
            dy = y + math.floor((i - 1) / 3) * (sliceSize + (targetHeight - 2 * sliceSize))
        else
            dy = y + 0
        end


        -- Draw the section
        love.graphics.draw(self.images[imageName], love.graphics.newQuad(sx, sy, sw, sh, imageWidth, imageHeight), dx, dy, 0, scaleX, scaleY)
    end
end
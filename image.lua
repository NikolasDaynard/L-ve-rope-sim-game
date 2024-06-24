-- thank you goodle

imageLib = {
    images = {},
    slices = {}
}

function imageLib:loadImage(imageName) 
    self.images[imageName] = love.graphics.newImage(imageName)
    self.images[imageName]:setFilter("nearest", "nearest")
end
function imageLib:loadSlicesImage(imageName, sliceSize) 
    sliceSize = sliceSize or 10
    imageLib:loadImage(imageName)
    imageLib:slice(imageName, sliceSize)
end

-- creates a 9 way slice, good for pixel art ui
function imageLib:slice(imageName, sliceSize) 
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
    self.slices[imageName].size = sliceSize
end

function imageLib:render(imageName, x, y, targetWidth, targetHeight)
    scaleX = scaleX or 1
    scaleY = scaleY or 1

    if self.images[imageName] ~= nil then
        if self.slices[imageName] == nil then
            local imageWidth, imageHeight = self.images[imageName]:getDimensions()
            love.graphics.draw(self.images[imageName], x, y, 0, targetWidth / imageWidth, imageHeight / targetHeight)
        else
            imageLib:renderSlices(imageName, self.slices[imageName], x, y, targetWidth, targetHeight)
        end
    else
        print(imageName)
        print("twas nil")
    end
end
function imageLib:renderSlices(imageName, slices, x, y, targetWidth, targetHeight)
    local imageWidth, imageHeight = self.images[imageName]:getDimensions()
    local sliceSize = self.slices[imageName].size or 10

    for i, slice in ipairs(slices) do
        local sx, sy, sw, sh = unpack(slice)
        local scaleX, scaleY
        local dx, dy

        if i == 2 or i == 8 then
            -- Top and bottom edges (stretch horizontally)
            scaleX = (targetWidth - 2 * sliceSize) / sw
            scaleY = 1
            dx = x + sliceSize * ((i - 1) % 3)
            if i == 2 then
                dy = y
            elseif i == 8 then
                dy = y + targetHeight - sliceSize
            end
        elseif i == 4 or i == 6 then
            -- Left and right edges (stretch vertically)
            scaleX = 1
            scaleY = (targetHeight - 2 * sliceSize) / sh
            dy = y + sliceSize * math.floor((i - 1) / 3)
            if i == 4 then
                dx = x
            elseif i == 6 then
                dx = x + targetWidth - sliceSize
            end
        elseif i == 5 then
            -- Center (stretch both horizontally and vertically)
            scaleX = (targetWidth - 2 * sliceSize) / sw
            scaleY = (targetHeight - 2 * sliceSize) / sh
            dx = x + sliceSize
            dy = y + sliceSize
        else
            -- Corners (no scaling)
            scaleX = 1
            scaleY = 1
            if i == 1 then
                dx = x
                dy = y
            elseif i == 3 then
                dx = x + targetWidth - sliceSize
                dy = y
            elseif i == 7 then
                dx = x
                dy = y + targetHeight - sliceSize
            elseif i == 9 then
                dx = x + targetWidth - sliceSize
                dy = y + targetHeight - sliceSize
            end
        end

        -- Draw the section
        love.graphics.draw(self.images[imageName], love.graphics.newQuad(sx, sy, sw, sh, imageWidth, imageHeight), dx, dy, 0, scaleX, scaleY)
    end
end

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
function lerp(a,b,t) 
    return a * (1-t) + b * t 
end
-- Replaces ${foo} with the value of the global foo
function interpolate(str)
    if str == nil or type(str) ~= "string" then
        return str
    end

    return (str:gsub("%${(.-)}", function(key)
        local chunk, err = load("return " .. key)
        if chunk then
            local success, result = pcall(chunk)
            if success then
                return tostring(result)
            end
        end
        return "${" .. key .. "}"
    end))
end

-- thanks S.O. Mateen Ulhaq
function splitString(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    local n = 1
    while true do
        local i, j = string.find(inputstr, sep, n)
        if not i then
            table.insert(t, string.sub(inputstr, n))
            break
        end
        table.insert(t, string.sub(inputstr, n, i - 1))
        n = j + 1
    end
    return t
end


function loadLevelScoreImages() 
    for i = 1, 100 do
        if levelScores[i] == 1 then
            levelImages[i] = "leveloutlinefc.png"
        elseif levelScores[i] ~= nil then
            levelImages[i] = "leveloutlinecleared.png"
        else
            levelImages[i] = "leveloutline.png"
        end
    end
end

-- shamefully stolen because I couldn't figure it out
function drawRotatedRect( mode, x, y, w, h, rx, ry, segments, r, ox, oy )
	-- Check to see if you want the rectangle to be rounded or not:
	if not oy and rx then r, ox, oy = rx, ry, segments end
	-- Set defaults for rotation, offset x and y
	r = r or 0
	ox = ox or w / 2
	oy = oy or h / 2
	-- You don't need to indent these; I do for clarity
	love.graphics.push()
		love.graphics.translate( x + ox, y + oy )
		love.graphics.push()
			love.graphics.rotate( -r )
			love.graphics.rectangle( mode, -ox, -oy, w, h, rx, ry, segments )
		love.graphics.pop()
	love.graphics.pop()
end

function exitGame() 
    love.window.close()
    love.event.quit()
end

function saveSettings()
    local jsonString = lunajson.encode(settings)
    love.filesystem.write("settings.json", jsonString)
end
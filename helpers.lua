function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
function lerp(a,b,t) 
    return a * (1-t) + b * t 
end
-- Replaces ${foo} with the value of the global foo
function interpolate(str)
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

function distance(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end
function lerp(a,b,t) 
    return a * (1-t) + b * t 
end
-- Replaces ${foo} with the value of the global foo
function interpolate(str)
    return (str:gsub("%${(.-)}", function(key)
        return tostring(_G[key] or "${" .. key .. "}")
    end))
end
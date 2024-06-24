soundLib = {
    sfx = {},
    soundSources = {},
    loops = {}
}

function soundLib:loadSound(name) 
    if self.sfx[name] == nil then
        self.sfx[name] = love.audio.newSource(name, "static")
    end
end

function soundLib:playSound(name, volume)
    if self.sfx[name] == nil then
        soundLib:loadSound(name) 
    end
    self.sfx[name]:play()
    table.insert(self.soundSources, self.sfx[name])
    self.soundSources[#self.soundSources]:setVolume(volume or 1)
    -- self.soundSources[#self.soundSources]:setPitch(0.5)
end

function soundLib:update()
    for i = #self.soundSources, 1, -1 do
        if not self.soundSources[i]:isPlaying() then
            if self.loops[self.soundSources[i]] then
                self.soundSources[i]:play()
            else
                table.remove(self.soundSources, i)
            end
        end
    end
end
function soundLib:loop(name, volume) 
    soundLib:playSound(name, volume)
    self.soundSources[#self.soundSources]:setLooping(true)
    self.loops[self.soundSources[#self.soundSources]] = true
end

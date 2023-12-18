local Settings = {
    brightness = 0.5,
    musicVolume = 0.8,
    sfxVolume = 0.7
}

function Settings:setBrightness(value)
    self.brightness = value
    -- Apply brightness changes in your game here
end

function Settings:setMusicVolume(value)
    self.musicVolume = value
    -- Adjust music volume in your game here
end

function Settings:setSfxVolume(value)
    self.sfxVolume = value
    -- Adjust sound effects volume in your game here
end

function Settings:getBrightness()
    return self.brightness
end

function Settings:getMusicVolume()
    return self.musicVolume
end

function Settings:getSfxVolume()
    return self.sfxVolume
end

return Settings
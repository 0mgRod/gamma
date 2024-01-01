-- savefile.lua
local SaveFile = {}

function SaveFile:save(filename, data)
    local success, message = love.filesystem.write(filename, data)
    if success then
        print("File saved successfully")
    else
        print("Failed to save file:", message)
    end
end

function SaveFile:load(filename)
    if love.filesystem.getInfo(filename) then
        local data = love.filesystem.read(filename)
        print("File loaded successfully")
        return data
    else
        print("File not found:", filename)
        return nil
    end
end

function SaveFile:getSaveFiles()
    local saveFiles = {}

    for i = 1, 3 do
        local filename = "savefile_" .. i .. ".txt"
        if love.filesystem.getInfo(filename) then
            table.insert(saveFiles, filename)
        else
            -- If file doesn't exist, create an empty one
            self:save(filename, "")
            table.insert(saveFiles, filename)
        end
    end

    return saveFiles
end

return SaveFile

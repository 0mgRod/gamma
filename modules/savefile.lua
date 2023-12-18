local SaveFile = {} -- 1

function SaveFile.save(slot)
    local filename = "saves/slot" .. slot .. ".csv" -- 2
    -- Implement saving logic here
    -- Open the file
    -- Write game data to the file
    -- Close the file
end

function SaveFile.load(slot)
    local filename = "saves/slot" .. slot .. ".csv" -- 3
    -- Implement loading logic here
    -- Open the file
    -- Read game data from the file
    -- Close the file
    -- Return the loaded data
end

return SaveFile -- 4
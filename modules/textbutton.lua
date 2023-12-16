local TextButton = {} -- Define the TextButton table
TextButton.__index = TextButton -- Set the metatable to itself

function TextButton:new(text, yPos, font, color)
    local this = {
        text = text,
        yPos = yPos,
        font = font,
        color = color or {1, 1, 1, 1}, -- Default color is white with full opacity
        selectedColor = {1, 1, 0, 0} -- Selected color is yellow with initial zero opacity
    }
    setmetatable(this, self)
    return this
end

return TextButton -- Don't forget to return the TextButton table at the end
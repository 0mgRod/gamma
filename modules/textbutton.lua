local TextButton = {}

function TextButton:new(text, action)
    local button = {
        text = text or "",
        action = action or function() end,
        selectedColor = {1, 1, 0, 0}, -- Default selected color (yellow)
        visible = true
    }
    setmetatable(button, { __index = TextButton })
    return button
end

return TextButton
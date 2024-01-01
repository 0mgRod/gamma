local Typewriter = require("libraries.typewriter")

local Cutscene = {}

function Cutscene.new(text, x, y, width, height)
    local self = Typewriter.new(text, x, y)

    self.width = width or love.graphics.getWidth() * 0.9
    self.height = height or love.graphics.getHeight() * 0.4

    function self:draw()
        love.graphics.setColor(0, 0, 0, 0.8) -- Black background
        love.graphics.rectangle("fill", x, y, self.width, self.height)

        love.graphics.setColor(1, 1, 1)  -- Set color to white
        love.graphics.printf(self.displayedText, x, y, self.width)
    end

    return self
end

return Cutscene

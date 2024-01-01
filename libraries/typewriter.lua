local Typewriter = {}

function Typewriter.new(text, x, y, delay)
    local self = {}

    self.text = text
    self.displayedText = ""
    self.x = x or 0
    self.y = y or 0
    self.delay = delay or 0.1
    self.timer = 0
    self.index = 1
    self.finishedTyping = false

    function self:update(dt)
        if not self.finishedTyping then
            self.timer = self.timer + dt
            if self.timer >= self.delay then
                self.timer = self.timer - self.delay
                self.displayedText = string.sub(self.text, 1, self.index)
                self.index = self.index + 1
                if self.index > #self.text then
                    self.finishedTyping = true
                end
            end
        end
    end

    function self:draw()
        love.graphics.print(self.displayedText, self.x, self.y)
    end

    return self
end

return Typewriter

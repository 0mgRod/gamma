player = require("modules.player")
TextButton = require("modules.textbutton")

local Menu = {}

function Menu:new()
    local menu = {
        buttons = {
            { text = "Play!", action = function() state = 1 player.frozen = false playerVisible = true end, selectedColor = {1, 1, 0, 0} },
            { text = "Settings", action = function() print("Settings button pressed") end, selectedColor = {1, 1, 0, 0} },
            { text = "Credits", action = function() print("Settings button pressed") end, selectedColor = {1, 1, 0, 0} },
            { text = "Quit", action = closegame.close, selectedColor = {1, 1, 0, 0} }
        },
        selectedButton = 1,
        logoFont = love.graphics.newFont("fonts/logo.ttf", 48),
        pixelFont = love.graphics.newFont("fonts/pixel.ttf", 26),
        pixelAltFont = love.graphics.newFont("fonts/pixelalt.ttf", 26)
    }
    setmetatable(menu, { __index = Menu })
    return menu
end

local delay = 0.2 -- Set the delay in seconds
local currentDelay = 0

function Menu:update(dt)
    currentDelay = currentDelay - dt

    -- Text button selection logic (Individual key presses)
    local fadeSpeed = 2 -- Adjust the fading speed

    for i, button in ipairs(self.buttons) do
        if i == self.selectedButton then
            button.selectedColor[4] = math.min(button.selectedColor[4] + fadeSpeed * dt, 1) -- Increase alpha to fade in
        else
            button.selectedColor[4] = math.max(button.selectedColor[4] - fadeSpeed * dt, 0) -- Decrease alpha to fade out
        end
    end

    if currentDelay <= 0 then
        if love.keyboard.isDown("up") then
            self.selectedButton = self.selectedButton - 1
            if self.selectedButton < 1 then
                self.selectedButton = #self.buttons
            end
            currentDelay = delay
        elseif love.keyboard.isDown("down") then
            self.selectedButton = self.selectedButton + 1
            if self.selectedButton > #self.buttons then
                self.selectedButton = 1
            end
            currentDelay = delay
        end
    end
end

function Menu:draw()
    -- Render "GAMMA" text
    love.graphics.setFont(self.logoFont)
    love.graphics.setColor(1, 1, 1, 1) -- Set color for "GAMMA" text
    local gammaWidth = self.logoFont:getWidth("GAMMA")
    love.graphics.print("GAMMA", love.graphics.getWidth() * 0.5 - gammaWidth * 0.5, love.graphics.getHeight() * 0.2)

    -- Calculate total height of all buttons
    local totalHeight = 0
    for _, button in ipairs(self.buttons) do
        totalHeight = totalHeight + self.pixelFont:getHeight(button.text)
    end

    -- Calculate the starting Y position for vertically centering the buttons
    local startY = love.graphics.getHeight() * 0.5 - totalHeight * 0.5

    -- Render text buttons
    for i, button in ipairs(self.buttons) do
        button.selectedColor[4] = math.max(button.selectedColor[4], 1) -- Ensure alpha is at least as high as unselected buttons

        love.graphics.setFont(self.pixelFont)

        if i == self.selectedButton then
            love.graphics.setColor(1, 1, 0, button.selectedColor[4])
        else
            love.graphics.setColor(1, 1, 1, 1)
        end

        local buttonWidth = self.pixelFont:getWidth(button.text)
        love.graphics.print(button.text, love.graphics.getWidth() * 0.5 - buttonWidth * 0.5, startY)
        startY = startY + self.pixelFont:getHeight(button.text) -- Move to the next button position
    end
end

function Menu:keypressed(key)
    if key == "return" then
        local selectedAction = self.buttons[self.selectedButton].action
        if selectedAction == "quit" then
            love.event.quit() -- Quit the game
        elseif selectedAction == "play" then
            state = 1
            playerVisible = true -- Show the player
            self.hideMenu = true -- Hide the menu
        elseif type(selectedAction) == "function" then
            selectedAction()
        end
    end
end


return Menu
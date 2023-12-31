local player = require("modules.player")
local TextButton = require("modules.textbutton")

local Menu = {}

local delay = 0.2
local currentDelay = 0

local MenuState = {
    MAIN_MENU = 1,
    CREDITS = 2,
}

local currentState = MenuState.MAIN_MENU
Menu.creditsMenu = nil

function Menu:new()
    local menu = {
        buttons = {
            { text = "Play!", action = function() state = 1 player.frozen = false playerVisible = true end, selectedColor = {1, 1, 0, 0} },
            -- { text = "Settings", action = function() print("Settings button pressed") end, selectedColor = {1, 1, 0, 0} },
            { text = "Credits", action = function() self:showCredits() end, selectedColor = {1, 1, 0, 0} },
            { text = "Full Version Preview", action = function() print("nope.") end, selectedColor = {1, 1, 0, 0} },
            { text = "Quit", action = function() love.event.quit() end, selectedColor = {1, 1, 0, 0} }
        },
        selectedButton = 1,
        logoFont = love.graphics.newFont("fonts/logo.ttf", 48),
        pixelFont = love.graphics.newFont("fonts/pixel.ttf", 26),
        pixelAltFont = love.graphics.newFont("fonts/pixelalt.ttf", 26),
        creditsMenu = nil,
    }
    setmetatable(menu, { __index = Menu })
    return menu
end

function Menu:showCredits()
    currentState = MenuState.CREDITS
    self.creditsMenu = self:createCreditsMenu()
end

function Menu:update(dt)
    currentDelay = currentDelay - dt

    if currentDelay <= 0 then
        local upPressed = love.keyboard.isDown("up")
        local downPressed = love.keyboard.isDown("down")

        if upPressed or downPressed then
            if currentState == MenuState.MAIN_MENU then
                if upPressed then
                    self:selectPreviousButton(self.buttons)
                elseif downPressed then
                    self:selectNextButton(self.buttons)
                end
                currentDelay = delay
            elseif currentState == MenuState.CREDITS then
                if upPressed then
                    self:selectPreviousButton(self.creditsMenu.buttons)
                elseif downPressed then
                    self:selectNextButton(self.creditsMenu.buttons)
                end
                currentDelay = delay
            end
        end
    end
end

function Menu:selectPreviousButton(currentButtons)
    local currentIndex = self.selectedButton
    local newIndex = currentIndex - 1

    if newIndex < 1 then
        newIndex = #currentButtons
    end

    local loopCount = 0
    while not currentButtons[newIndex].visible and loopCount < #currentButtons do
        newIndex = newIndex - 1
        if newIndex < 1 then
            newIndex = #currentButtons
        end
        loopCount = loopCount + 1
    end

    if newIndex ~= currentIndex then
        self.selectedButton = newIndex
    end
end

function Menu:selectNextButton(currentButtons)
    local currentIndex = self.selectedButton
    local newIndex = currentIndex + 1

    if newIndex > #currentButtons then
        newIndex = 1
    end

    local loopCount = 0
    while not currentButtons[newIndex].visible and loopCount < #currentButtons do
        newIndex = newIndex + 1
        if newIndex > #currentButtons then
            newIndex = 1
        end
        loopCount = loopCount + 1
    end

    if newIndex ~= currentIndex then
        self.selectedButton = newIndex
    end
end

function Menu:keypressed(key)
    if currentState == MenuState.MAIN_MENU then
        if key == "return" then
            local selectedAction = self.buttons[self.selectedButton].action
            if selectedAction then
                selectedAction()
            end
        end
    elseif currentState == MenuState.CREDITS then
        if key == "escape" then
            currentState = MenuState.MAIN_MENU
            self.selectedButton = 1
        elseif key == "return" then
            local selectedButton = self.creditsMenu.buttons[self.selectedButton]
            if selectedButton and selectedButton.url then
                love.system.openURL(selectedButton.url)
            else
                currentState = MenuState.MAIN_MENU
                self.selectedButton = 1
            end
        end
    end
end

function Menu:createCreditsMenu()
    local creditsMenu = {
        buttons = {
            { text = "Lead Developer - OmgRod", url = "https://github.com/0mgRod", selectedColor = {1, 1, 0, 0}, visible = true },
            { text = "LPC Tile Atlas - adrix89", url = "https://opengameart.org/content/lpc-tile-atlas", selectedColor = {1, 1, 0, 0}, visible = true },
            { text = "Soundtrack - Kevin MacLeod", url = "https://incompetech.com/music/royalty-free/music.html", selectedColor = {1, 1, 0, 0}, visible = true },
            { text = "Back", action = function() currentState = MenuState.MAIN_MENU end, selectedColor = {1, 1, 0, 0}, visible = true },
        },
        selectedButton = 1,
        pixelFont = love.graphics.newFont("fonts/pixel.ttf", 26),
    }
    return creditsMenu
end

function Menu:draw()
    if currentState == MenuState.MAIN_MENU then
        love.graphics.setFont(self.logoFont)
        love.graphics.setColor(1, 1, 1, 1)
        local gammaWidth = self.logoFont:getWidth("GAMMA")
        love.graphics.print("GAMMA", love.graphics.getWidth() * 0.5 - gammaWidth * 0.5, love.graphics.getHeight() * 0.2)

        local totalHeight = 0
        for _, button in ipairs(self.buttons) do
            totalHeight = totalHeight + self.pixelFont:getHeight(button.text)
        end

        local startY = love.graphics.getHeight() * 0.5 - totalHeight * 0.5

        for i, button in ipairs(self.buttons) do
            love.graphics.setFont(self.pixelFont)

            if i == self.selectedButton then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end

            local buttonWidth = self.pixelFont:getWidth(button.text)
            love.graphics.print(button.text, love.graphics.getWidth() * 0.5 - buttonWidth * 0.5, startY)
            startY = startY + self.pixelFont:getHeight(button.text)
        end
    elseif currentState == MenuState.CREDITS then
        love.graphics.clear(0, 0, 0, 1)

        love.graphics.setFont(self.pixelFont)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print("Credits", 100, 50)

        local totalHeight = 0
        for _, button in ipairs(self.creditsMenu.buttons) do
            totalHeight = totalHeight + self.pixelFont:getHeight(button.text)
        end

        local startY = love.graphics.getHeight() * 0.5 - totalHeight * 0.5

        for i, button in ipairs(self.creditsMenu.buttons) do
            love.graphics.setFont(self.pixelFont)

            if i == self.selectedButton then
                love.graphics.setColor(1, 1, 0, 1)
            else
                love.graphics.setColor(1, 1, 1, 1)
            end

            local buttonWidth = self.pixelFont:getWidth(button.text)
            love.graphics.print(button.text, love.graphics.getWidth() * 0.5 - buttonWidth * 0.5, startY)
            startY = startY + self.pixelFont:getHeight(button.text)
        end
    end
end

return Menu
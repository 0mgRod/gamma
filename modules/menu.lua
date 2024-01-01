local player = require("modules.player")
local TextButton = require("modules.textbutton")

local Menu = {}

local MenuState = {
    MAIN_MENU = 1,
    CREDITS = 2,
    PLAYING = 3,
}

local currentState = MenuState.MAIN_MENU

local currentMusic = nil
local musicPath = "assets/music/AdventuresInAdventureland.mp3"

local delay = 0.2
local currentDelay = 0

function Menu:new()
    local menu = {
        buttons = {
            {
                text = "Play!",
                action = function()
                    if currentState == MenuState.MAIN_MENU then
                        currentState = MenuState.PLAYING
                        love.audio.stop(currentMusic)
                        currentMusic = nil
                        state = 1
                        player.frozen = false
                        playerVisible = true
                    end
                end,
                selectedColor = {1, 1, 0, 0}
            },
            {
                text = "Settings",
                action = function()
                    -- Add logic for settings button if needed
                end,
                selectedColor = {1, 1, 0, 0}
            },
            {
                text = "Credits",
                action = function()
                    currentState = MenuState.CREDITS
                end,
                selectedColor = {1, 1, 0, 0}
            },
            {
                text = "Full Version Preview",
                action = function()
                    print("nope.")
                end,
                selectedColor = {1, 1, 0, 0}
            },
            {
                text = "Quit",
                action = function()
                    love.event.quit()
                end,
                selectedColor = {1, 1, 0, 0}
            }
        },
        selectedButton = 1,
        logoFont = love.graphics.newFont("fonts/logo.ttf", 48),
        pixelFont = love.graphics.newFont("fonts/pixel.ttf", 26),
        creditsMenu = {
            buttons = {
                {
                    text = "Lead Developer - OmgRod",
                    url = "https://github.com/0mgRod",
                    selectedColor = {1, 1, 0, 0},
                    visible = true
                },
                {
                    text = "LPC Tile Atlas - adrix89",
                    url = "https://opengameart.org/content/lpc-tile-atlas",
                    selectedColor = {1, 1, 0, 0},
                    visible = true
                },
                {
                    text = "Soundtrack - Kevin MacLeod",
                    url = "https://incompetech.com/music/royalty-free/music.html",
                    selectedColor = {1, 1, 0, 0},
                    visible = true
                },
                {
                    text = "Back",
                    action = function()
                        currentState = MenuState.MAIN_MENU
                    end,
                    selectedColor = {1, 1, 0, 0},
                    visible = true
                },
            },
            selectedButton = 1,
            pixelFont = love.graphics.newFont("fonts/pixel.ttf", 26),
        },
    }
    setmetatable(menu, { __index = Menu })
    return menu
end

function Menu:update(dt)
    if (currentMusic == nil or love.audio.getActiveSourceCount() == 0) and
        (currentState == MenuState.CREDITS or currentState == MenuState.MAIN_MENU) then
        currentMusic = love.audio.newSource(musicPath, "stream")
        currentMusic:setLooping(true)
        love.audio.play(currentMusic)
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
        elseif key == "up" then
            self:selectPreviousButton(self.buttons)
        elseif key == "down" then
            self:selectNextButton(self.buttons)
        end
    elseif currentState == MenuState.CREDITS then
        if key == "escape" then
            currentState = MenuState.MAIN_MENU
            self.selectedButton = 1
        elseif key == "return" then
            local selectedButton = self.creditsMenu.buttons[self.selectedButton]
            if selectedButton then
                if selectedButton.url then
                    love.system.openURL(selectedButton.url)
                elseif selectedButton.action then
                    selectedButton.action()
                end
            end
        elseif key == "up" then
            self:selectPreviousButton(self.creditsMenu.buttons)
        elseif key == "down" then
            self:selectNextButton(self.creditsMenu.buttons)
        end
    end
end

function Menu:draw()
    love.graphics.setFont(self.logoFont)
    love.graphics.setColor(1, 1, 1, 1)
    local gammaWidth = self.logoFont:getWidth("GAMMA")
    love.graphics.print("GAMMA", love.graphics.getWidth() * 0.5 - gammaWidth * 0.5, love.graphics.getHeight() * 0.2)

    local totalHeight = 0
    local buttons = currentState == MenuState.MAIN_MENU and self.buttons or self.creditsMenu.buttons

    for _, button in ipairs(buttons) do
        totalHeight = totalHeight + self.pixelFont:getHeight(button.text)
    end

    local startY = love.graphics.getHeight() * 0.5 - totalHeight * 0.5

    for i, button in ipairs(buttons) do
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

return Menu
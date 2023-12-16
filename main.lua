local anim8 = require("libraries.anim8")
local AspectRatio = require("libraries.aspectratio")
local wait = require("libraries.wait")
require("libraries.closegame")
local player = require("modules.player") -- Import the player module
local cutscene = require("modules.cutscene")
local Menu = require("modules.menu")
local TextButton = require("modules.textbutton")

local GameManager = require("modules.gameManager")
local player = require("modules.player") -- Import the player module
local Menu = require("modules.menu")

function love.load()
    -- Load player details using the player module
    player.load(800, 600)

    -- Initialize menu
    menu = Menu:new()
end

function love.update(dt)
    menu:update(dt)

    -- Update player using the player module if it's visible and the state is 1
    if GameManager.isPlayerVisible() and GameManager.getCurrentState() == 1 then
        player.update(dt)
    end
end

function love.draw()
    if playerVisible and state == 1 then
        player.draw()
    elseif not menu.hideMenu then
        menu:draw()
    end
end

function love.keypressed(key)
    menu:keypressed(key)
    -- Check for specific keys to trigger showing the player
    if key == "return" then
        GameManager.showPlayer()
    end
end

local anim8 = require("libraries.anim8")
local AspectRatio = require("libraries.aspectratio")
local wait = require("libraries.wait")
local camera = require("libraries.camera")
local sti = require("libraries.sti")
require("libraries.closegame")

local player = require("modules.player") -- Import the player module
local cutscene = require("modules.cutscene")
local Menu = require("modules.menu")
local TextButton = require("modules.textbutton")
local GameManager = require("modules.gameManager")

function love.load()
    cam = camera()
    
    gameMap = sti("maps/mainmap.lua")

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

    cam:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    if cam.x < w/2 then
        cam.x = w/2
    end

    if cam.y < h/2 then
        cam.y = h/2
    end

    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight

    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end

    if cam.y > (mapH - h/2) then
        cam.y = (mapH - h/2)
    end
end

function love.draw()
        if state == 1 then
            cam:attach()
                gameMap:drawLayer(gameMap.layers["Terrain"])
                gameMap:drawLayer(gameMap.layers["Path"])
                gameMap:drawLayer(gameMap.layers["Objects3"])
                gameMap:drawLayer(gameMap.layers["Objects4"])
                if playerVisible then
                    player.draw()
                end
                gameMap:drawLayer(gameMap.layers["Walls"])
                gameMap:drawLayer(gameMap.layers["Walls2"])
                gameMap:drawLayer(gameMap.layers["Objects1"])
                gameMap:drawLayer(gameMap.layers["Objects2"])
            cam:detach()
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

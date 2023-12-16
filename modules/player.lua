local anim8 = require("../libraries.anim8")

local player = {}

local defaultWidth = 800
local defaultHeight = 600

function player.load()
    player.x = defaultWidth / 2
    player.y = defaultHeight / 2
    player.speed = 3
    player.frozen = true

    player.spriteSheet = love.graphics.newImage('assets/player.png')
    player.spriteSheet:setFilter("nearest", "nearest")
    local frameWidth = 20
    local frameHeight = 30
    local imageWidth = player.spriteSheet:getWidth()
    local imageHeight = player.spriteSheet:getHeight()
    local g = anim8.newGrid(frameWidth, frameHeight, imageWidth, imageHeight, 0, 0, 0)

    player.animations = {
        down = anim8.newAnimation(g(1, 1, 2, 1), 0.2),
        up = anim8.newAnimation(g(1, 2, 2, 2), 0.2),
        left = anim8.newAnimation(g(1, 3, 2, 3), 0.2),
        right = anim8.newAnimation(g(1, 4, 2, 4), 0.2)
    }

    player.currentAnimation = player.animations.down
    player.previousAnimation = player.animations.down
end

function player.update(dt)
    local scaledSpeed = player.speed * math.min(love.graphics.getWidth() / defaultWidth, love.graphics.getHeight() / defaultHeight)
    local movementKeyPressed = false

    -- Movement logic
    if not player.frozen then
        local dx, dy = 0, 0
        
        -- Keyboard inputs
        if love.keyboard.isDown("left") then
            dx = dx - scaledSpeed
            player.currentAnimation = player.animations.left
            movementKeyPressed = true
        end
        if love.keyboard.isDown("right") then
            dx = dx + scaledSpeed
            player.currentAnimation = player.animations.right
            movementKeyPressed = true
        end
        if love.keyboard.isDown("up") then
            dy = dy - scaledSpeed
            player.currentAnimation = player.animations.up
            movementKeyPressed = true
        end
        if love.keyboard.isDown("down") then
            dy = dy + scaledSpeed
            player.currentAnimation = player.animations.down
            movementKeyPressed = true
        end
        
        -- Diagonal movement normalization
        if dx ~= 0 and dy ~= 0 then
            dx = dx * 0.7071 -- Approximate value for 1/sqrt(2)
            dy = dy * 0.7071
        end
        
        -- Remove the boundary checks
        player.x = player.x + dx
        player.y = player.y + dy
    else
        -- Unfreeze animation if movement keys are pressed
        if love.keyboard.isDown("up") or love.keyboard.isDown("down") or
            love.keyboard.isDown("left") or love.keyboard.isDown("right") then
            player.frozen = false
            movementKeyPressed = true
        end
    end
    
    -- Animation control
    if not movementKeyPressed then
        player.currentAnimation:gotoFrame(1)
        player.currentAnimation:pause()
    else
        player.currentAnimation:resume()
    end
    
    player.currentAnimation:update(dt)
end

function player.draw()
    local desiredWidth = 40  -- Change this value to adjust the player's size
    local spriteWidth, spriteHeight = player.currentAnimation:getDimensions()

    local scaleX = desiredWidth / spriteWidth
    local scaleY = desiredWidth / spriteWidth  -- Maintain the aspect ratio for y-direction

    player.currentAnimation:draw(player.spriteSheet, player.x, player.y, nil, scaleX, scaleY, scaleX / 2, scaleY / 2)
end

return player
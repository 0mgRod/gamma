-- gameManager.lua

local GameManager = {}

local playerVisible = false
local state = 0

function GameManager.showPlayer()
    playerVisible = true
    state = 1
end

function GameManager.isPlayerVisible()
    return playerVisible
end

function GameManager.getCurrentState()
    return state
end

return GameManager

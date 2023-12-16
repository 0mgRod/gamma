local AspectRatio = {}

function AspectRatio.calculateMargins(defaultWidth, defaultHeight)
    local windowWidth = love.graphics.getWidth()
    local windowHeight = love.graphics.getHeight()

    local aspectRatio = defaultWidth / defaultHeight
    local windowAspectRatio = windowWidth / windowHeight

    local marginX, marginY

    if windowAspectRatio > aspectRatio then
        marginX = (windowWidth - aspectRatio * windowHeight) / 2
        marginY = 0
    else
        marginX = 0
        marginY = (windowHeight - windowWidth / aspectRatio) / 2
    end

    return marginX, marginY
end

return AspectRatio

local wait = {}

function wait.forSeconds(seconds)
    if type(seconds) ~= "number" or seconds <= 0 then
        error("Invalid duration for wait.forSeconds()")
    end

    local start = love.timer.getTime()
    while love.timer.getTime() - start < seconds do
        coroutine.yield()
    end
end

return wait
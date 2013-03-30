local touchy = require "toucher"
local x, y = 100, 200

-- 
-- LOVE EVENTS --
--
function love.load()
    touchy:load()
end

function love.update(dt)
    touchy:update(dt)
end

function love.keypressed(c)
    touchy:keyDown(c)
end

function love.keyreleased(c)
    touchy:keyUp(c)
end

function love.draw()
    touchy:draw()
end

-- 
-- HELPER FUNCTIONS --
--
love.keyboard.allDown = function(...)
    for _,v in ipairs(arg) do
        if not love.keyboard.isDown(v) then return false end
    end
    return true
end

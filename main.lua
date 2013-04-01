require "map-functions"
local touchy = require "toucher"
local x, y = 100, 200
local linda

-- 
-- LOVE EVENTS --
--
function love.load()
    loadMap('maps/chez-peter.lua')
    linda = love.graphics.newImage('lin.png')
    love.graphics.setBackgroundColor(255,255,255)
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
    drawMap()
    love.graphics.draw(linda, 300, 300)
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

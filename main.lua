local anim8 = require "anim8"
local image, animation
local x, y = 100, 200

function love.load()
    image = love.graphics.newImage('toucher.png')
    local grid = anim8.newGrid(32, 48, image:getWidth(), image:getHeight())
    local groove =  grid(1,1 , '3-7,1' , '6-3,1' , 1,1 , '8-12,1' , '11-8,1')
    animation = anim8.newAnimation('loop', groove, 0.06)
end

function love.update(dt)
    x = love.mouse.getX()
    y = love.mouse.getY()
    animation:update(dt)
end

function love.draw()
    animation:draw(image, x + 20, y + 20)
end

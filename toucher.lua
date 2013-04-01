local Mover = require "mover"
local toucher = {
    x=100, 
    y=100,
    speed=50,
    update = function(self, dt)
        if love.keyboard.isDown('up','down','left','right') then
            self:selectAnimation('walk_down')
        else
            self.velocity.y,self.velocity.x = 0,0
            if self.animation then self.animation:reset() end
            self:selectAnimation(false)
        end

        self.x = self.x + (self.velocity.x * dt)
        self.y = self.y + (self.velocity.y * dt)
        if self.animation then
            self.animation:update(dt)
        end
    end
}
Mover(toucher)

function toucher:load()
    self.gfx = love.graphics.newImage('toucher.png')
    self:set_grid(32,48)
    self:add_animation('walk_down', 'loop', 0.06, nil,
        1,1 , '3-7,1' , '6-3,1' , 1,1 , '8-12,1' , '11-8,1')
    self:add_quad('down',0,0)
end

function toucher:keyDown(c)
    if 'up' == c then
        self.velocity.y = 0 - self.speed
    elseif 'down' == c then
        self.velocity.y = self.speed
    elseif 'left' == c then
        self.velocity.x = 0 - self.speed
    elseif 'right' == c then
        self.velocity.x = self.speed
    end
end

function toucher:keyUp(c)
    if 'up' == c then
        self.velocity.y = love.keyboard.isDown('down') and self.speed or 0
    elseif 'down' == c then
        self.velocity.y = love.keyboard.isDown('up') and (0 - self.speed) or 0
    elseif 'left' == c then
        self.velocity.x = love.keyboard.isDown('right') and self.speed or 0
    elseif 'right' == c then
        self.velocity.x = love.keyboard.isDown('left') and (0 - self.speed) or 0
    end
end

return toucher:new()

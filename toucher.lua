local Mover = require "mover"
local toucher = {
  x=100,y=100,speed=100,
  update = function(self, dt)
    -- check for arrow keys and update position
    local isup = love.keyboard.isDown('up')
    local isdown = love.keyboard.isDown('down')
    local isleft = love.keyboard.isDown('left')
    local isright = love.keyboard.isDown('right')

    if isup or isdown or isleft or isright then
      self:selectAnimation('walk_down')
      if isup then
        self.y = self.y - (self.speed * dt)
      end
      if isdown then
        self.y = self.y + (self.speed * dt)
      end
      if isleft then
        self.x = self.x - (self.speed * dt)
      end
      if isright then
        self.x = self.x + (self.speed * dt)
      end
    else
      -- stop animation
      if self:animation() then self:animation():reset() end
      self:selectAnimation(false)
      -- self.velocity.y,self.velocity.x = 0,0
    end

    -- Update animation
    if self:animation() then
      self:animation():update(dt)
    end

    -- check to see if toucher has reached edge of screen
    if GLOBALS.screen.height < self:getBottom() then
      love.event.push('transition', 'down')
    elseif 0 > self.y then
      love.event.push('transition', 'up')
    elseif GLOBALS.screen.width < self:getRight() then
      love.event.push('transition', 'right')
    elseif 0 > self.x then
      love.event.push('transition', 'left')
    end
  end
}
-- Mover(toucher)

function toucher:load()
  self.gfx = love.graphics.newImage('toucher.png')
  self:set_grid(32,48)
  self:add_animation('walk_down', 'loop', 0.06, nil,
      1,1 , '3-7,1' , '6-3,1' , 1,1 , '8-12,1' , '11-8,1')
  self:add_quad('down',0,0)
end

-- updates position according to dx and dy... mostly for map transitions
function toucher:setPos(dt,dx,dy)
  self.x = self.x + (dx*dt)
  self.y = self.y + (dy*dt)
end

return Mover:new(toucher)

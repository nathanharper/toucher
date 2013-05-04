-- This is the basis of all moving objects in the game.
-- create the table representation fo your class and then
-- call "Mover(class)" on it.
local anim8 = require "anim8"
local Class = require "class"
local mt = {
  x=0,y=0,
  dir='down',
  velocity = {x=0,y=0},
  accel = {x=0,y=0},
  bb = {l=nil,t=nil,w=nil,h=nil}, -- bounding box
  animations={},
  gfx=false,
  curr_anim=false,
  quad_size = {width=0,height=0},
  quads = {
    up=false,
    down=false,
    left=false,
    right=false
  }
}
Class(mt)
-- mt.__index = mt
-- setmetatable(mt, mt)

-- Helper functions for getting bottom/right position of image.
function mt:getBottom()
  return self:getHeight() + self.y
end
function mt:getRight()
  return self:getWidth() + self.x
end
function mt:getWidth()
  return self.quad_size.width
end
function mt:getHeight()
  return self.quad_size.height
end

function mt:setBoundingBox(l,t,w,h)
  self.bb.l,self.bb.t,self.bb.w,self.bb.h = l,t,w,h
end

function mt:animation()
  return self.curr_anim and self.animations[self.curr_anim]
end

function mt:selectAnimation(name)
  self.curr_anim = name
end

function mt:update(dt)
  self.x = self.x + self.velocity.x
  self.y = self.y + self.velocity.y
  if self.curr_anim then
    self.animations[self.curr_anim]:update(dt)
  end
end

function mt:draw()
  if not self.curr_anim then
    if not self.quads[self.dir] then
      love.graphics.draw(self.gfx)
    else
      love.graphics.drawq(self.gfx, self.quads[self.dir], self.x, self.y)
    end
  else
    self.animations[self.curr_anim]:draw(self.gfx, self.x, self.y)
  end
end

-- create the anim8 grid and quad size
-- Good idea to call this first when initializing a new Mover
function mt:set_grid(width, height)
  self.quad_size.width = width
  self.quad_size.height = height
  -- TODO: this will break if gfx is unset
  self.grid = anim8.newGrid(
    self.quad_size.width, self.quad_size.height, 
    self.gfx:getWidth(), self.gfx:getHeight())
end

function mt:add_animation(name, type, time, callback, ...)
  assert(self.grid, "no goddam greeeeeed")
  self.animations[name] = anim8.newAnimation(type, self.grid(unpack(arg)), time)
  if callback then
    self.animations[name]:addCallback(callback)
  end
end

function mt:add_quad(where, top, left)
  self.quads[where] = love.graphics.newQuad(
    top, left, 
    self.quad_size.width, self.quad_size.height,
    self.gfx:getWidth(), self.gfx:getHeight()
  )
end

-- used by bump.lua
function mt:getBBox(item)
  return self.x, self.y, self:getWidth(), self:getHeight()
end
return mt

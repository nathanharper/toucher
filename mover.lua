-- This is the basis of all moving objects in the game.
-- create the table representation fo your class and then
-- call "Mover(class)" on it.
local anim8 = require "anim8"

-- Helper functions for getting bottom/right position of image.
local function getBottom(self)
    return self:getHeight() + self.y
end
local function getRight(self)
    return self:getWidth() + self.x
end
local function getWidth(self)
    return self.quad_size.width
end
local function getHeight(self)
    return self.quad_size.height
end

local function setBoundingBox(self,l,t,w,h)
  self.bb.l,self.bb.t,self.bb.w,self.bb.h = l,t,w,h
end

return function(class, vals)
    local defaults = {
        x=0,
        y=0,
        dir='down',
        velocity = {
            x=0,
            y=0
        },
        accel = {
            x=0,
            y=0
        },
        bb = { -- bounding box for collisions relative to top-left corner of item
          l=nil,t=nil,w=nil,h=nil
        },
        animations={},
        gfx=false,
        curr_anim=false,
        quad_size = {
            width=0,
            height=0
        },
        quads = {
            up=false,
            down=false,
            left=false,
            right=false
        }
    }

    if vals then
        for k,v in pairs(vals) do
            defaults[k] = v
        end
    end

    local mt = {
        __index = defaults,
        __metatable = defaults
    }

    setmetatable(class, mt)

    local idx_func = function(t,k)
        if 'animation' == k then
            return t.curr_anim and t.animations[t.curr_anim]
        else
            return class[k]
        end
        return false
    end

    class.new = class.new or function(_, init)
        init = init or {}
        return setmetatable(init, {__index = idx_func})
    end

    function class:selectAnimation(name)
        self.curr_anim = name
    end

    class.update = class.update or function(self, dt)
        self.x = self.x + self.velocity.x
        self.y = self.y + self.velocity.y
        if self.curr_anim then
            self.animations[self.curr_anim]:update(dt)
        end
    end

    class.draw = class.draw or function(self)
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
    class.set_grid = class.set_grid or function(self, width, height)
        self.quad_size.width = width
        self.quad_size.height = height
        -- TODO: this will break if gfx is unset
        self.grid = anim8.newGrid(
            self.quad_size.width, self.quad_size.height, 
            self.gfx:getWidth(), self.gfx:getHeight())
    end

    class.add_animation = class.add_animation or function(self, name, type, time, callback, ...)
        assert(self.grid, "no goddam greeeeeed")
        self.animations[name] = anim8.newAnimation(type, self.grid(unpack(arg)), time)
        if callback then
            self.animations[name]:addCallback(callback)
        end
    end

    class.add_quad = class.new_quad or function(self, where, top, left)
        self.quads[where] = love.graphics.newQuad(
            top, left, 
            self.quad_size.width, self.quad_size.height,
            self.gfx:getWidth(), self.gfx:getHeight()
        )
    end

    -- set some helper functions for getting graphic dimensions
    class.getBottom = getBottom
    class.getRight = getRight
    class.getHeight = getHeight
    class.getWidth = getWidth
    class.setBoundingBox = setBoundingBox
end

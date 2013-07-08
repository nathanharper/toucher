-- This wraps some of the functionality of 
-- kikito's "bump" collision library.
if BUMP then return BUMP end

local bump = require "bump"

bump.initialize(32)

-- Bounding Box is in the "bb" attribute
function bump.getBBox(item)
  if item.static == false then
    return item:getBBox()
  else
    return item.bb.l, item.bb.t, item.bb.w, item.bb.h
  end
end

-- Tells bump whether or not 2 items can collide
function bump.shouldCollide(i1,i2)
  if i1.collision_name == 'toucher' or i2.collision_name == 'toucher' then
    return true
  end
  return false
end

function bump.collision(i1,i2,dx,dy)
  local tooch, other
  if i1.collision_name == 'toucher' then
    tooch, other = i1, i2
  else
    tooch, other = i2, i1
  end

  local right = tooch:getRight()
  -- if right >= other.l and right <= other.l+other.w then
  -- elseif tooch.x >= other.l and tooch
end

function bump.endCollision(i1,i2)
  print('collision over')
end

-- remove all collision items
function bump.clear()
  bump.each(function(item)
    if item.collision_name == 'block' then
      bump.remove(item)
    end
  end)
end

return bump

-- This wraps some of the functionality of 
-- kikito's "bump" collision library.
local bump = require "bump"

bump.initialize(32)

-- Bounding Box is in the "bb" attribute
function bump.getBBox(item)
    return item.bb.l, item.bb.t, item.bb.w, item.bb.h
end

-- Tells bump whether or not 2 items can collide
function bump.shouldCollide(i1,i2)
    return true
end

function bump.collision(i1,i2,dx,dy)
    print('collision!')
end

function bump.endCollision(i1,i2)
    print('collision over')
end

return bump

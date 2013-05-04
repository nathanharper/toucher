local touchy = require "toucher"
-- local bump = require "bump" -- small collision detection lib

--[====================[ 
GAME STATE
--]====================] 
local STATE = {
  world = nil,        -- reference for what map to use at different coordinates
  gamestate = 'play',
  transition = nil,
  map = {
    curr = nil,     -- current map SpriteBatch
    prev = nil      -- this is used to animate map transitions
  }
}

--[====================[ 
LOVE EVENTS
--]====================] 
function love.load()
  -- print(_VERSION)
  local mapname = WORLD.loadWorld('worlds/1.lua')
  STATE.map.curr = MAP.loadMap('maps/' .. mapname .. '.lua')
  love.graphics.setBackgroundColor(255,255,255)
  touchy:load()
end

function love.update(dt)
  if STATE.gamestate == 'play' then -- Normal game state
    touchy:update(dt) -- Update character position
    processEvents()
  elseif STATE.gamestate == 'transition' then -- map is in transition
    -- update current map, previous map, and toucher
    STATE.map.curr:updateMap(dt,STATE.transition.dx,STATE.transition.dy)
    if STATE.map.prev then 
      STATE.map.prev:updateMap(dt,STATE.transition.dx,STATE.transition.dy)
    end
    touchy:setPos(dt,STATE.transition.dx,STATE.transition.dy)

    -- if any coordinate hits 0, transition is over.
    if (STATE.map.curr.x <= 0 and STATE.transition.dx < 0) 
    or (STATE.map.curr.y <= 0 and STATE.transition.dy < 0)
    or (STATE.map.curr.x >= 0 and STATE.transition.dx > 0)
    or (STATE.map.curr.y >= 0 and STATE.transition.dy > 0)
    then endTransition() end
  end
end

-- function love.keypressed(c)
--     touchy:keyDown(c)
-- end

-- function love.keyreleased(c)
--     touchy:keyUp(c)
-- end

function love.draw()
  STATE.map.curr:drawMap()
  if STATE.map.prev then STATE.map.prev:drawMap() end
  touchy:draw()
end

--[====================[ 
HELPER FUNCTIONS
--]====================]

-- This function is called in the main 'update' callback.
-- Polls for any events and processes them.
-- Most collisions are processed as events, as well as screen transitions
function processEvents()
  local e,a,b,c,d
  for e,a,b,c,d in love.event.poll() do
    if     'transition' == e then
      startTransition(a) -- 'a' is the direction
    elseif 'collision' == e then
      -- a and b are collion objects. c and d are x and y collision coords?
    end
  end
end

love.keyboard.allDown = function(...)
  for _,v in ipairs(arg) do
    if not love.keyboard.isDown(v) then return false end
  end
  return true
end

-- Player has reached edge of screen, start transition to new room
-- @param direction : up, down, left, right
function startTransition(direction)
  STATE.gamestate = 'transition'
  STATE.map.prev = STATE.map.curr
  STATE.map.curr = MAP.loadMap('maps/' .. WORLD.getNextMap(direction) .. '.lua')
  if     'up' == direction then
    STATE.map.curr.y = 0 - GLOBALS.screen.height
    STATE.transition = {dx=0,dy=GLOBALS.transition_speed}
  elseif 'down' == direction then
    STATE.map.curr.y = GLOBALS.screen.height
    STATE.transition = {dx=0,dy=(0 - GLOBALS.transition_speed)}
  elseif 'left' == direction then
    STATE.map.curr.x = 0 - GLOBALS.screen.width
    STATE.transition = {dx=GLOBALS.transition_speed,dy=0}
  elseif 'right' == direction then
    STATE.map.curr.x = GLOBALS.screen.width
    STATE.transition = {dx=(0 - GLOBALS.transition_speed),dy=0}
  end
end

function endTransition()
  STATE.map.curr.x,STATE.map.curr.y = 0,0
  STATE.gamestate = 'play'
  STATE.map.prev = nil
  STATE.transition = nil
  if touchy.x <= 0 then touchy.x = 1 end
  if touchy:getRight() >= GLOBALS.screen.width then 
    touchy.x = GLOBALS.screen.width - 1 - touchy:getWidth()
  end
  if touchy.y <= 0 then touchy.y = 1 end
  if touchy:getBottom() >= GLOBALS.screen.height then 
    touchy.y = GLOBALS.screen.height - 1 - touchy:getHeight() 
  end
end

--[==============================[ 
BUMP CALLBACKS AND DEFINITIONS
--]==============================]
-- function bump

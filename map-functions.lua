-- Helper functions for the sprite container
local drawMap = function(self)
  love.graphics.draw(self.sprite,self.x,self.y)
end

local updateMap = function(self,dt,dx,dy)
  dx = dx or 0
  dy = dy or 0
  self.x = self.x + (dx*dt)
  self.y = self.y + (dy*dt)
end

local function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
  local tileW,tileH = tileWidth,tileHeight
  local tileset = love.graphics.newImage(tilesetPath)
  
  local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
  local sprite = love.graphics.newSpriteBatch(tileset) -- TODO: set max num of sprites
  
  local quads = {}
  
  for _,info in ipairs(quadInfo) do
    -- info[1] = the character, info[2] = x, info[3] = y
    quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW,  tileH, tilesetW, tilesetH)
  end
  
  local width = #(tileString:match("[^\n]+"))

  local rowIndex,columnIndex = 1,1
  for row in tileString:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    columnIndex = 1
    for character in row:gmatch(".") do
      sprite:addq(quads[character], (columnIndex-1)*tileW, (rowIndex-1)*tileH)
      columnIndex = columnIndex + 1
    end
    rowIndex=rowIndex+1
  end

  -- init x,y, and acceleration
  local container = {
      x=0,y=0,
      sprite = sprite,
      drawMap = drawMap,
      updateMap = updateMap
  }

  return container
end

local function loadMap(path)
  return love.filesystem.load(path)()
end

return {
  loadMap = loadMap,
  newMap = newMap
}

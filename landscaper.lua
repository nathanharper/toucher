local landscaper = {}
local lands = {}
local width, height, blockW, blockH

local function check_range(left,top)
  assert(left > 0 and left <= #lands and top > 0 and top <= #lands[1],
    ("out of range: %s %s"):format(left,top))
end

-- TODO: implement the boolean table from the Lua manual
function landscaper.init(w,h,bw,bh)
  width,height,blockW,blockH = w,h,bw,bh
  for i=1,w do
    local row = {}
    for j=1,h do row[#row+1] = false end
    lands[#lands+1] = row
  end
end

function landscaper.add(l,t)
  local left = math.floor(l/blockW)+1
  local top = math.floor(t/blockH)+1
  if not pcall(check_range,left,top) then return end
  lands[left][top] = true
end

-- return "true" if the provided point has collided
function landscaper.collide(x,y)
  local left = math.floor(x/blockW)+1
  local top = math.floor(y/blockH)+1
  if not pcall(check_range,left,top) then return end
  print(left,top)
  return lands[left][top]
end

function landscaper.clear()
  for x,t in ipairs(lands) do
    for y,_ in ipairs(t) do lands[x][y] = false end
  end
end

return landscaper

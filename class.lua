--[[
*REALLY* simple class creator
--]]
local function Class(defaults)
  local mt = defaults or {}
  mt.__index = mt.__index or mt
  setmetatable(mt, mt);

  function mt.new(self, init)
    return setmetatable(init or {}, mt);
  end

  return mt
end
return Class

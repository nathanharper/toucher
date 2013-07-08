local tileString = [[
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
                         
]]

local quadInfo = { 
  { ' ',  0,  0, false }, -- gray floor
  -- { '#',  0, 32, true  }  -- brick wall
}

return MAP.newMap(32,32,'/images/lab.png', tileString, quadInfo)

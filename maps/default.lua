local tileString = [[
#########################
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#                       #
#########################
]]

local quadInfo = { 
  { ' ',  0,  0 }, -- gray floor
  { '#',  0, 32 }  -- brick wall
}

return newMap(32,32,'/images/lab.png', tileString, quadInfo)

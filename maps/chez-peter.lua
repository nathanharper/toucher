local tileString = [[
###########  ############
#                #      #
#  L[]R   L[]R   # L[]R #
#  L()R   L()R   # L()R #
#                #      #
#                ###  ###
#  L[]R   L[]R          #
#  L()R   L()R    L[]R  #
#                 L()R  #
                         
   L[]R   L[]R           
#  L()R   L()R   ###  ###
#                #LL  RR#
#                #LL  RR#
#  L[]R   L[]R   #LL  RR#
#  L()R   L()R   #LL  RR#
#                #LL  RR#
###########  ############
]]

local quadInfo = { 
  { ' ',  0,  0, false }, -- floor 
  { '[', 32,  0, true  }, -- table top left
  { ']', 64,  0, true  }, -- table top right
  { '(', 32, 32, true  }, -- table bottom left
  { ')', 64, 32, true  }, -- table bottom right
  { 'L',  0, 32, true  }, -- chair on the left
  { 'R', 96, 32, true  }, -- chair on the right
  { '#', 96,  0, true  }  -- bricks
}

return MAP.newMap(32,32,'/images/resto.png', tileString, quadInfo)

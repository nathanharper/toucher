local tileString = [[
###########  ############
# AAA^AAAAA       # ^^^ #
# |||@|||||       # @@@ #
#                 #     #
# AAAAAAA^AA      ### ###
# |||||||@||        # # #
#                   * * #
# *                 l l #
# l                     #
          ^              
          @              
# *                     #
# l                     #
#                       #
# AAAAA^AAA^AAA^    ^^  #
# |||||@|||@|||@    @@  #
#                       #
###########  ############
]]

local quadInfo = { 
  { ' ',  0,  0, false }, -- gray floor
  { '#',  0, 32, true  }, -- brick wall
  { '^', 32,  0, true  }, -- mainframe 1 top
  { '@', 32, 32, true  }, -- mainframe 1 bottom
  { 'A', 64,  0, true  }, -- mainframe 2 top
  { '|', 64, 32, true  }, -- maingrame 2 bottom
  { '*', 96,  0, true  }, -- plant top
  { 'l', 96, 32, true  }  -- plant bottom
}

return MAP.newMap(32,32,'/images/lab.png', tileString, quadInfo)

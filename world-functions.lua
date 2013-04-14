local maps, world, start, x, y

-- Load the map, get initial x/y coords
function loadWorld(path)
    local data = love.filesystem.load(path)()
    maps = data.maps
    world = data.world
    start = data.start
    x = data.start.x
    y = data.start.y
    return getCurrentMap()
end

-- see if there's a map at a coordinate.
function getNextMap(direction)
    if     'up'    == direction then y = y - 1
    elseif 'down'  == direction then y = y + 1
    elseif 'left'  == direction then x = x - 1
    elseif 'right' == direction then x = x + 1 end

    return getCurrentMap()
end

function getCurrentMap()
    -- print(x,y)
    local mapname = 'default'
    if world[y] and world[y][x] then mapname = maps[world[y][x]] end
    return mapname
end

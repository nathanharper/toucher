-- 
-- TOUCHER config file
-- 

-- GLOBALS
GLOBALS = {
    screen = {
        width = 800,
        height = 568
    },
    transition_speed = 600
}

-- 
-- CONFIG
--
function love.conf(t)
    t.title = "Butt Toucher"
    t.author = "Nasty Nate"
    t.screen.width = GLOBALS.screen.width
    t.screen.height = GLOBALS.screen.height
    t.screen.fullscreen = false
    -- t.screen.vsync = false
    t.modules.joystick = false
    t.modules.physics = false
end

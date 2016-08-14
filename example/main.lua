require "object"
require "objects.world"
require "objects.enemy"
require "objects.player"
require "objects.spawner"

local world, player, spawner

function love.load(arg)
    -- create world
    world = new: world()
    
    -- create player
    player = new: player(world)
    
    -- create enemy spawner
    spawner = new: spawner("enemy", 0.4, function()
        return world, math.random(10, love.graphics.getWidth() - 10), -10
    end)
end

function love.update(dt)
    -- you can retrieve return values from events.
    -- you will receive a table indexed by instances
    local r = event: update(dt)
    
    -- this line would delete any object spawned by the spawner.
    -- pointless, but a good example
    --delete(r[spawner])
    
    if love.keyboard.isDown("escape") then
        love.event.quit()
    end
end

function love.draw()
    event: draw()
end

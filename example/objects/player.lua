require "object"
require "objects.bullet"
require "objects.timer"

object: player
{
    x     = 200;
    y     = 710;
    image = love.graphics.newImage "assets/player.png";
    speed = 150;
    score = 0;
    
    isAlive       = true;
    canShoot      = true;
    shootInterval = 0.2;
    
    construct = function(world)
        self.world = world
        local w, h = image:getWidth(), image:getHeight()
        world.add(self, x, y, w, h)
    end;
    
    collision = function(other)
        if typeof(other) == "enemy" then
            delete(other)
            isAlive = false
        end
    end;
    
    update = function(dt)
        if isAlive then
            local right_x_boundary = love.graphics.getWidth() - image:getWidth()
            if love.keyboard.isDown("a", "left") and x > 0 then
                x = x - speed * dt
            elseif love.keyboard.isDown("d", "right") and x < right_x_boundary then
                x = x + speed * dt
            end
            
            if love.keyboard.isDown("space", "lctrl", "rctrl") and canShoot then
                -- shoot bullet
                canShoot = false
                new: bullet(world, self, x + image:getWidth() / 2, y)
                new: timer(shootInterval, function() canShoot = true end)
            end
            
            -- update physics
            world.move(self, x, y)
        elseif love.keyboard.isDown("r") then
            isAlive = true
            score   = 0
            for k, v in pairs(world.objects) do
                if k ~= self then delete(k) end
            end
        end
    end;
    
    draw = function()
        if isAlive then
            love.graphics.draw(image, x, y)
        else
            love.graphics.print("Press 'R' to restart", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 10)
        end
    end;
    
    destruct = function()
        world.remove(self)
    end;
}

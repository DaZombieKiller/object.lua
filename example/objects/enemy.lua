require "object"

object: enemy
{
    x     = 0;
    y     = 0;
    image = love.graphics.newImage "assets/enemy.png";
    
    construct = function(world, x, y)
        self.world = world
        self.x = x
        self.y = y
        local w, h = image:getWidth(), image:getHeight()
        world.add(self, x, y, w, h)
    end;
    
    update = function(dt)
        y = y + 200 * dt
        if y > 850 then delete(self) return end
        
        -- update physics
        world.move(self, x, y)
    end;
    
    collision = function(other)
        if typeof(other) == "bullet" then
            delete(self)
        end
    end;
    
    draw = function()
        love.graphics.draw(image, x, y)
    end;
    
    destruct = function()
        world.remove(self)
    end;
}

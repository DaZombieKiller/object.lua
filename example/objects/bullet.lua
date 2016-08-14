require "object"

object: bullet
{
    x     = 0;
    y     = 0;
    image = love.graphics.newImage "assets/bullet.png";
    
    construct = function(world, owner, x, y)
        self.world = world
        self.owner = owner
        self.x = x
        self.y = y
        local w, h = image:getWidth(), image:getHeight()
        world.add(self, x, y, w, h)
    end;
    
    update = function(dt)
        y = y - 250 * dt
        if y < 0 then delete(self) return end
        
        -- update physics
        world.move(self, x, y)
    end;
    
    draw = function()
        love.graphics.draw(image, x, y)
    end;
    
    collision = function(other)
        if typeof(other) == "enemy" then
            owner.score = owner.score + 100
            delete(self)
        end
    end;
    
    destruct = function()
        world.remove(self)
    end;
}

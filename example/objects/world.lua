require "object"

object: world
{
    objects = {};
    
    checkCollision = function(x1, y1, w1, h1, x2, y2, w2, h2)
        return x1 < x2 + w2 and
               x2 < x1 + w1 and
               y1 < y2 + h2 and
               y2 < y1 + h1
    end;
    
    add = function(obj, x, y, w, h)
        objects[obj] = { x = x, y = y, w = w, h = h }
    end;
    
    remove = function(obj)
        objects[obj] = nil
    end;
    
    move = function(obj, x, y, w, h)
        if objects[obj] then
            objects[obj].x = x
            objects[obj].y = y
            objects[obj].w = w or objects[obj].w
            objects[obj].h = h or objects[obj].h
        end
    end;
    
    update = function(dt)
        for o1, v1 in pairs(objects) do
            for o2, v2 in pairs(objects) do
                if checkCollision(v1.x, v1.y, v1.w, v1.h, v2.x, v2.y, v2.w, v2.h) then
                    if o1.collision then o1.collision(o2) end
                    if o2.collision then o2.collision(o1) end
                end
            end
        end
    end;
}

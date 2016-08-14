require "object"
require "objects.timer"

object: spawner
{
    timer      = nil;
    spawn_type = nil;
    spawn_argf = nil;
    spawn_time = nil;
    
    construct = function(obj, t, f)
        spawn_type = obj
        spawn_argf = f
        spawn_time = t
    end;
    
    update = function(dt)
        if not timer or timer.dead then
            timer = new: timer(spawn_time, function()
                new(spawn_type, spawn_argf())
            end)
        end
    end;
}

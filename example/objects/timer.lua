require "object"

object: timer
{
    time_left = 0;
    func      = nil;
    args      = nil;
    dead      = false;
    
    construct = function(t, f, ...)
        time_left = t
        func      = f
        args      = {...}
    end;
    
    update = function(dt)
        time_left = time_left - dt
        if time_left < 0 then
            func((unpack or table.unpack)(args))
            dead = true
            delete(self)
        end
    end;
}

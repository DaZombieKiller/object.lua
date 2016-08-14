--[[ object.lua

    Object system for Lua
    =====================
    Designed for use with Love2D
    written by TheZombieKiller
    
    Dependencies
    ============
    deepcopy.lua - https://gist.github.com/DaZombieKiller/1b5690842b8138a4024c55760e2d253f#file-deepcopy-lua
    
    Usage
    =====
    object: <object name>
    {
        member = default_value;
        
        construct = function(...)
        end;
        
        destruct = function(...)
        end;
        
        <et cetera>
    }
    
    local instance = new: <object name>(...)
    print(typeof(instance))
    instance.method(...)
    event: update() -- calls update method on all instances that have it
    delete(instance)
    
    An object cannot contain a member named "self".
    Usage of self.<member name> inside a member function is not necessary,
    as you can access the member directly, without using "self". However, you can
    optionally use it anyway, because self is automatically assigned to the instance.
    
    License
    =======
    Copyright (c) 2016 Benjamin Moir

    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

require "deepcopy"

local __instances = {}
local __objects   = {}

local function call_index(t, func, ...)
    local args = {...}
    if #args > 0 then
        return getmetatable(t).__index(nil, func)(nil, ...)
    else
        return function(...)
            return getmetatable(t).__index(nil, func)(nil, ...)
        end
    end
end

object = setmetatable({}, {
    __call     = call_index,
    __newindex = function() end,
    __index    = function(_, k)
        return function(_, body)
            if body.self ~= nil then error "an object cannot contain 'self'" end
            __objects[k] = body
        end
    end,
})

new = setmetatable({}, {
    __call     = call_index,
    __newindex = function() end,
    __index    = function(_, n)
        return function(_, ...)
            if not __objects[n] then error("unknown object '" .. n .. "'") end
            local instance = {}
            local data     = table.deepcopy(__objects[n], { function_env = instance }, {
                ["userdata"] = function(stack, orig, copy, state, arg1, arg2)
                    return orig, true
                end,
            })
            __instances[instance] = setmetatable(instance, {
                __index = function(t, k)
                    if k == "self" then
                        return instance
                    else
                        return data[k] or (_ENV or _G)[k]
                    end
                end,
                
                __newindex = function(t, k, v)
                    data[k] = v
                end,
                
                __object = n,
            })
            if instance.construct then instance.construct(...) end
            return instance
        end
    end,
})

delete = function(instance, ...)
    if not instance then return end
    __instances[instance] = nil
    if instance.destruct then return instance.destruct(...) end
end

typeof = function(instance)
    if not instance then return nil end
    return getmetatable(instance).__object
end

event = setmetatable({}, {
    __call     = call_index,
    __newindex = function() end,
    __index    = function(_, method)
        return function(_, ...)
            local r = {}
            for instance in pairs(__instances) do
                if instance[method] then
                    r[instance] = instance[method](...)
                end
            end
            return r
        end
    end,
})
